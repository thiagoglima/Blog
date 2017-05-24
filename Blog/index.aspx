<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Blog.Web.index" %>

<!DOCTYPE html>

<html lang="pt-br">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="description" content="Investidor Inovador, Dicas de Investimento inovadoras.">
    <meta name="url" content="http://www.investidorinovador.com.br">
    <meta name="copyright" content="Investidor Inovador">
    <meta name="robots" content="index,follow">

    <link rel="shortcut icon" href="favicon.ico">
    <link rel="apple-touch-icon" sizes="144x144" type="image/x-icon" href="favicon.png">

    <title>Investidor Inovador</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/blog.css" rel="stylesheet" />
    <link href="css/menu.css" rel="stylesheet" />
    <link href="css/newsletter.css" rel="stylesheet" />
    <link href="css/controles.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,300,500,600,700" rel="stylesheet">

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/blog.js"></script>
    <script src="js/eModal.min.js"></script>
    <script src="https://use.fontawesome.com/fc09a6ef32.js"></script>



    <script type="text/javascript">

        var xDocumentos = null;
        var xPostsCarregados = 3;
        var xExecutarFila = false;
        var xPreenchido = true;
        var xCategoria = "";
        var xIDs = "";

        function FiltrarCategoria(categoria) {
            xCategoria = categoria;
            xIDs = "";
            BuscarPosts(true);
            return false;
        }

        function BuscarPosts(xExecutar) {

            if (!ValidaVariavel(xIDs)) { xIDs = ""; }

            if (!ValidaVariavel(xCategoria)) { xCategoria = ""; }

            var xUrl = '<%= Blog.Web.code.Configuracoes.HttpLocation + "xml/posts.aspx?id=" %>' + xIDs + "&categoria=" + xCategoria;
            xExecutarFila = xExecutar;

            if (!ValidaVariavel(xUrl)) { return; }

            SubmitHttp(xUrl, ContruirPosts);
        }

        function ContruirPosts() {
            try {
                if (xmlHttp["ContruirPosts"].readyState == 4) {
                    var xmlDoc = xmlHttp["ContruirPosts"].responseXML;

                    if (xmlHttp["ContruirPosts"].status == 200) {

                        if (!ValidaVariavel(xmlDoc)) {
                            CorrigirTela();
                            return;
                        }

                        if (xDocumentos == null) {
                            xDocumentos = new Array();
                        }

                        var xTotal = xmlDoc.children[0].childElementCount;

                        for (var i = 0; i < xTotal; i++) {
                            var xSelecionado = xmlDoc.children[0].children[i];

                            try {
                                var xID = xSelecionado.children[0].innerHTML;
                                var xImg = xSelecionado.children[1].innerHTML;
                                var xTitulo = xSelecionado.children[4].innerHTML;
                                var xDescricao = xSelecionado.children[5].innerHTML;
                                var xData = xSelecionado.children[6].innerHTML;
                                var xAutor = xSelecionado.children[7].innerHTML;

                                if (!ValidaVariavel(xDescricao)) { continue; }
                                if (!ValidaVariavel(xTitulo)) { continue; }
                                if (!ValidaVariavel(xID)) { continue; }

                                var xDivPost = document.createElement("div");
                                xDivPost.setAttribute("class", "col-md-12 blog-post");

                                if (ValidaVariavel(xImg)) {
                                    var xDivImg = document.createElement("div");
                                    xDivImg.setAttribute("class", "post-imagem");

                                    var xImgSrc = document.createElement("img");
                                    xImgSrc.setAttribute("alt", "postImagem");
                                    xImgSrc.setAttribute("src", "arquivos/" + xImg);

                                    xDivImg.appendChild(xImgSrc);
                                    xDivPost.appendChild(xDivImg);
                                }

                                var xDivTitulo = document.createElement("div");
                                xDivTitulo.setAttribute("class", "post-titulo");

                                var xOpenPost = document.createElement("a");
                                xOpenPost.setAttribute("onclick", "return AbrirPost(" + xID + ");");

                                var xH1Titulo = document.createElement("h1");
                                xH1Titulo.innerHTML = xTitulo;

                                xOpenPost.appendChild(xH1Titulo);
                                xDivTitulo.appendChild(xOpenPost);
                                xDivPost.appendChild(xDivTitulo);

                                var xDivInformacao = document.createElement("div");
                                xDivInformacao.setAttribute("class", "post-informacao");

                                var xSpanInformacao = document.createElement("span");
                                xSpanInformacao.innerHTML = xData;

                                var xLinkAutor = document.createElement("a");
                                xLinkAutor.innerHTML = " Por: " + xAutor;

                                xSpanInformacao.appendChild(xLinkAutor);
                                xDivInformacao.appendChild(xSpanInformacao);
                                xDivPost.appendChild(xDivInformacao);

                                var xDivConteudo = document.createElement("p");
                                xDivConteudo.innerHTML = xDescricao;

                                xDivPost.appendChild(xDivConteudo);


                                var xContinuarLeitura = document.createElement("a");
                                xContinuarLeitura.setAttribute("class", "button button-style button-anim fa fa-long-arrow-right");
                                xContinuarLeitura.setAttribute("onclick", "return AbrirPost(" + xID + ");");

                                var xSpanLeitura = document.createElement("span");
                                xSpanLeitura.innerHTML = "Continuar Lendo...";

                                xContinuarLeitura.appendChild(xSpanLeitura);
                                xDivPost.appendChild(xContinuarLeitura);
                                xDocumentos.push(xDivPost);

                                xIDs = xIDs + xID + ",";
                            }
                            catch (e) {
                                console.log(e.message);
                                continue;
                            }
                        }


                        CorrigirTela();

                        if (xExecutarFila) {
                            ExecutarFilaPosts();
                        }

                    }
                }
            }
            catch (e) {
                console.log(e.message);
                return;
            }
        }

        function ExecutarFilaPosts() {
            try {

                if (!ValidaVariavel(xDocumentos)) {
                    return;
                }

                if (xDocumentos.length <= 0) {
                    return;
                }

                if (xPostsCarregados <= 0)
                { xPostsCarregados = 3; }

                var xPai = document.getElementById('divPostPai');

                if (!ValidaVariavel(xPai)) { return; }

                var xCarregados = new Array();

                for (var i = 0; i < xPostsCarregados; i++) {
                    try {
                        if (i > xDocumentos.length)
                        { continue; }

                        var xPost = xDocumentos[i];

                        if (!ValidaVariavel(xPost)) { continue; }

                        xPai.appendChild(xPost);
                        xCarregados.push(i);
                    }
                    catch (e) {
                        console.log(e.message);
                        continue;
                    }
                }

                for (var i = 0; i <= xCarregados.length; i++) {
                    try { xDocumentos.splice(xCarregados[i], 1); } catch (e) { continue; }
                }

                if (!ValidaVariavel(xDocumentos))
                { BuscarPosts(false); }
                else if (xDocumentos.length <= 0)
                { BuscarPosts(false); }
                else
                { CorrigirTela(); }
            }
            catch (e) {
                console.log(e.message);
                return;
            }
        }

        function CorrigirTela() {
            var xOcultarBotao = false;
            var xMostrarVazio = false;

            try {
                if (!ValidaVariavel(xDocumentos)) {
                    xOcultarBotao = true;
                }

                if (xDocumentos.length <= 0) {
                    xOcultarBotao = true;
                }

                var xPainel = document.getElementById('divPostPai');

                if (xPainel.children.length <= 0)
                { xMostrarVazio = true; }

                if (xOcultarBotao) {
                    document.getElementById('divBotao').style.display = "none";
                }
                else {
                    document.getElementById('divBotao').style.display = "";
                }

                if (xMostrarVazio) {
                    document.getElementById('divPostPai').style.display = "none";
                }
                else {
                    document.getElementById('divPostPai').style.display = "";
                }
            }
            catch (e) {
                console.log(e.message);
                xOcultarBotao = true;
                xMostrarVazio = true;
            }
        }

        function AbrirPost(id) {
            try {
                if (!ValidaVariavel(id))
                { return; }

                var xUrl = '<%= Blog.Web.code.Configuracoes.HttpLocation + "post?id=" %>' + id;

                if (!ValidaVariavel(xUrl)) { return; }


                eModal.iframe(xUrl, ' ', AbrirPost);

                return false;
            }
            catch (e) {
                console.log(e.message);
                return false;
            }
        }

        function FecharInicio() {
            try {
                document.getElementById('btnFecharNews').click();
            }
            catch (e)
            { console.log(e.message); }
        }


        $(window).scroll(function () {
            if ($(this).scrollTop() >= 500) {
                $('.scroll-to-top').fadeIn();
            } else {
                $('.scroll-to-top').fadeOut();
            }
        });


        $('.scroll-to-top').click(function () {
            $('html, body').animate({ scrollTop: 0 }, 800);
            return false;
        });


        function ExibirRetorno(xMsg, erro) {
            if (!ValidaVariavel(xMsg)) { return; }

            try {

                if (erro) {
                    document.getElementById('retorno').setAttribute("status", "erro");
                }
                else {
                    document.getElementById('retorno').setAttribute("status", "sucesso");
                    document.getElementById('<%= txtEmail.ClientID %>').value = '';
                    document.getElementById('<%= txtNome.ClientID %>').value = '';
                    document.getElementById('<%= txtEmpresa.ClientID %>').value = '';
                    document.getElementById('<%=  txtInteresses.ClientID %>').value = '';
                }

                document.getElementById('retornoMsg').innerHTML = xMsg;
                document.getElementById('retorno').style.opacity = 1;
                setTimeout("document.getElementById('retorno').style.opacity = 0;", 4000);
            }
            catch (e) {
                console.log(e.message);
                return;
            }
        }

    </script>

    <style>
        .modal-content {
            padding: 20px;
        }

        .modal-header {
            border: none;
            padding: 0;
        }

            .modal-header button {
                font-size: 35px;
            }
    </style>


</head>
<body onload="BuscarPosts(true);">
    <form id="form1" runat="server">

        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>

        <nav class="navbar menuPadrao">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle togglePersonalizado" data-toggle="collapse" data-target="#menuPrincipal">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">
                        <img src="img/Logo_Branco_64.png" alt="logo" style="height: 64px;" />
                    </a>
                </div>
                <div class="collapse navbar-collapse" id="menuPrincipal">
                    <ul id="menu" runat="server" class="nav navbar-nav">
                    </ul>
                </div>
            </div>
        </nav>


        <div id="modalNews" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-xl" role="document">
                <div class="modal-content" style="padding: 0;">
                    <div class="containernews">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12">
                                    <div class="divTituloNews">
                                        <img src="img/Logo_Branco_64.png" alt="logo" style="height: 64px;" />
                                        <h1>Deseja Assinar Nossa Newsletter e Ficar Por Dentro de Todas as Novidades ?</h1>
                                        <h3>é rapidinho e não dói :)</h3>
                                    </div>
                                    <div class="text-input col-md-6 col-sm-6">
                                        <input autocomplete="off" class="txtPadrao form-control" id="txtCadNome" runat="server" maxlength="100" placeholder="Nome" type="text" aria-invalid="true">
                                    </div>
                                    <div class="text-input col-md-6 col-sm-6">
                                        <input autocomplete="off" class="txtPadrao form-control" id="txtCadEmail" runat="server" maxlength="100" placeholder="E-mail" type="text" aria-invalid="true">
                                    </div>
                                    <div class="text-input col-md-6 col-sm-6">
                                        <input autocomplete="off" class="txtPadrao form-control" id="txtCadEmpresa" runat="server" maxlength="100" placeholder="Empresa" type="text" aria-invalid="true">
                                    </div>
                                    <div class="text-input col-md-6 col-sm-6">
                                        <input autocomplete="off" class="txtPadrao form-control" id="txtCadInteresses" runat="server" maxlength="100" placeholder="Interesses" type="text" aria-invalid="true">
                                    </div>
                                    <div class="text-input col-md-6 col-sm-6">
                                        <input id="btnFecharNews" type="button" style="width: 100%;" data-dismiss="modal" class="btn btn-danger botaoPadrao" value="Não Obrigado">
                                    </div>
                                    <div class="text-input col-md-6 col-sm-6">
                                        <asp:Button ID="btnCadCadastrarNews" OnClick="btnCadCadastrarNews_Click" Style="width: 100%;" runat="server" CssClass="btn btn-success botaoPadrao" Text="Assinar Newsletter" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid divPrincipal">
            <div class="row">
                <div class="col-md-0">
                    <div class="fixedLeft">
                        <div class="redes">
                            <div class="facebook botaoRede">
                                <a href="https://www.facebook.com/investidorinovador/" onclick="window.open('https://www.facebook.com/investidorinovador/', 'newwindow', 'width=600, height=550'); return false;" target="_blank">
                                    <img src="img/facebook_branco_60.png" class="imgSocial" alt="facebook" />
                                </a>
                            </div>
                            <div class="twitter botaoRede">
                                <a href="https://www.twitter.com/investidorinova" onclick="window.open('https://www.twitter.com/investidorinova', 'newwindow', 'width=600, height=550'); return false;" target="_blank">
                                    <img src="img/twitter_branco_60.png" class="imgSocial" alt="twitter" />
                                </a>
                            </div>
                            <div class="instagram botaoRede">
                                <a href="https://www.instagram.com/investidorinovador/" onclick="window.open('https://www.instagram.com/investidorinovador/', 'newwindow', 'width=600, height=550'); return false;" target="_blank">
                                    <img src="img/instagram_branco_60.png" class="imgSocial" alt="instagram" />
                                </a>
                            </div>
                            <div class="email botaoRede">
                                <a href="mailto:contato@investidorinovador.com.br">
                                    <img src="img/email_branco_60.png" class="imgSocial" alt="email" />
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="col-md-12 corpo">
                        <div id="divPostPai" class="row">
                        </div>
                        <div id="divBotao" class="col-md-12" style="border-top: 1px dashed #CCC; text-align: center;">
                            <div class="container-fluid">
                                <div style="padding: 40px; border-top: 1px dashed #CCC;">
                                    <button onclick="BuscarPosts(true);return false;" class="btn btn-danger botaoRedondo">Mais Posts</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="containernews">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12">
                        <div class="divAssinar">

                            <div class="divTituloNews">
                                <h1>Fique Por dentro das Novidades !</h1>
                                <h3>Assine nossa newsletter</h3>
                            </div>

                            <div class="text-input col-md-6 col-sm-6">
                                <input autocomplete="off" class="txtPadrao form-control" id="txtNome" runat="server" maxlength="100" placeholder="Nome" type="text" aria-invalid="true">
                            </div>
                            <div class="text-input col-md-6 col-sm-6">
                                <input autocomplete="off" class="txtPadrao form-control" id="txtEmail" runat="server" maxlength="100" placeholder="E-mail" type="text" aria-invalid="true">
                            </div>
                            <div class="text-input col-md-6 col-sm-6">
                                <input autocomplete="off" class="txtPadrao form-control" id="txtEmpresa" runat="server" maxlength="100" placeholder="Empresa" type="text" aria-invalid="true">
                            </div>
                            <div class="text-input col-md-6 col-sm-6">
                                <input autocomplete="off" class="txtPadrao form-control" id="txtInteresses" runat="server" maxlength="100" placeholder="Interesses" type="text" aria-invalid="true">
                            </div>
                            <asp:Button ID="btnCadastrarNews" OnClick="btnCadastrarNews_Click" runat="server" CssClass="btn btn-danger botaoPadrao" Text="Assinar Newsletter" />

                            <div id="retorno" class="retorno" status="sucesso" style="opacity: 0;">
                                <div style="display: inline-block;">
                                    <label id="retornoMsg" class="retornoMsg"></label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="containeirInstitucional">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="textoInstitucional">
                            <h3>O Que fazemos, Mas que site é esse ?</h3>
                            <span>
                                <p>Se você tem interesse em conhecer novas formas de investir seu dinheiro esta página é para você. </p>
                                <p>Investidor inovador é um blog  que tem como objetivo levar informações às pessoas sobre a transformação que a inovação está trazendo ao universo financeiro.</p>

                            </span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div style="text-align: right !important;">
                            <h3>Outras Informações</h3>
                            <p>contato@investidorinovador.com</p>
                            <img src="img/Logo_Preto_64.png" alt="logoInvestidorInovador" />
                            <p style="margin-bottom: 0;">Investidor Inovador 2017</p>
                            <p style="font-size: 9px;">© Copyright 2017. Todos os Direitos Reservados</p>
                        </div>
                    </div>
                </div>
            </div>


        </div>



        <a href="#" class="scroll-to-top"><i class="fa fa-long-arrow-up"></i></a>
        <a href="#" class="scroll-to-top"><i class="fa fa-long-arrow-up"></i></a>
    </form>



    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
                m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-99717399-1', 'auto');
        ga('send', 'pageview');

     </script>


    <script>

        $('#modalNews').modal('show');

    </script>
</body>
</html>
