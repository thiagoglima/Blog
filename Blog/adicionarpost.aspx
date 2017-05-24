<%@ Page Language="C#" EnableEventValidation="false" ValidateRequest="false" AutoEventWireup="true" CodeBehind="adicionarpost.aspx.cs" Inherits="Blog.Web.adicionarpost" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <meta name="description" content="Investidor Inovador, Dicas de Investimento inovadoras." />
    <meta name="url" content="http://www.investidorinovador.com.br" />
    <meta name="copyright" content="Investidor Inovador" />
    <meta name="robots" content="index,follow" />

    <link rel="shortcut icon" href="favicon.ico" />
    <link rel="apple-touch-icon" sizes="144x144" type="image/x-icon" href="favicon.png" />

    <title>Investidor Inovador</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/blog.css" rel="stylesheet" />
    <link href="css/menu.css" rel="stylesheet" />
    <link href="css/newsletter.css" rel="stylesheet" />
    <link href="css/controles.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,300,500,600,700" rel="stylesheet" />


    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/eModal.min.js"></script>

    <script src="https://cloud.tinymce.com/stable/tinymce.min.js?apiKey=e3dp0100xo8fshm6x5moytvqevezide0xgkfkksi1crvdguf"></script>
    <script>
        tinymce.init({
            selector: 'textarea',
            height: 500,
            theme: 'modern',
            plugins: [
                'advlist autolink lists link image charmap print preview hr anchor pagebreak',
                'searchreplace wordcount visualblocks visualchars code fullscreen',
                'insertdatetime media nonbreaking save table contextmenu directionality',
                'emoticons template paste textcolor colorpicker textpattern imagetools codesample toc help'
            ],
            toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
            toolbar2: 'print preview media | forecolor backcolor emoticons | codesample help',
            image_advtab: true,
            templates: [
                { title: 'Test template 1', content: 'Test 1' },
                { title: 'Test template 2', content: 'Test 2' }
            ],
            content_css: [
                '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
                '//www.tinymce.com/css/codepen.min.css'
            ]
        });

        function SetarHid() {
            try {
                document.getElementById('hidConteudoHtml').value = tinymce.get('txtConteudo').getContent();
                document.getElementById('hidConteudoTxt').value = tinymce.get('txtConteudo').getContent({ format: 'text' });
            }
            catch (e) {
                console.log(e.message);
            }

            return true;
        }

    </script>

    <style>
        html, body {
            background: #FFF;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div>
                        <h1>Cadastrar Novo Post</h1>
                    </div>
                    <asp:HiddenField ClientIDMode="Static" ID="hidConteudoTxt" runat="server" />
                    <asp:HiddenField ClientIDMode="Static" ID="hidConteudoHtml" runat="server" />
                    <input autocomplete="off" class="txtPadrao form-control" id="txtLogin" runat="server" maxlength="100" placeholder="Login" required="required" type="text" aria-invalid="true">
                    <input autocomplete="off" class="txtPadrao form-control" id="txtSenha" runat="server" maxlength="100" placeholder="Senha" required="required" type="password" aria-invalid="true">
                    <input autocomplete="off" class="txtPadrao form-control" id="txtTituloPost" runat="server" maxlength="100" placeholder="Titulo do Post" required="required" type="text" aria-invalid="true">
                    <input autocomplete="off" class="txtPadrao form-control" id="txtHash" runat="server" maxlength="100" placeholder="Assuntos" type="text" aria-invalid="true">
                    <input autocomplete="off" class="txtPadrao form-control" id="txtNomeImagem" runat="server" maxlength="100" placeholder="Imagem do Titulo" type="text" aria-invalid="true">
                    
                    <h5 style="margin: 5px;">Categoria do Post</h5>
                    <asp:DropDownList ID="dropCategoria" runat="server" CssClass="btn btn-default dropdown-toggle" Style="width: 100%; margin: 5px;">
                    </asp:DropDownList>


                    <input autocomplete="off" style="display: none;" class="txtPadrao form-control" id="txtRetornoUpload" runat="server" maxlength="100" type="text" aria-invalid="true">

                    <textarea id="txtConteudo" runat="server"></textarea>
                    <asp:Button ID="btnCadastrar" OnClientClick="SetarHid();" OnClick="btnCadastrar_Click" Style="width: 100%;" runat="server" CssClass="btn btn-success botaoPadrao" Text="Cadastrar" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
