<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="post.aspx.cs" Inherits="Blog.Web.post" %>

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

    <style>
        html, body {
            background: #FFF;
        }
    </style>


</head>
<body>
    <form id="formPosts" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div id="divImagem" runat="server" class="col-md-12">
                </div>
                <div id="divTitulo" runat="server" class="col-md-12">
                </div>
                <div id="divInformacao" runat="server" class="col-md-12">
                </div>
                <div id="divConteudo" class="col-md-12" runat="server">
                </div>
            </div>
        </div>

        <div class="container-fluid" style="margin-top: 50px;">
            <div class="row">
                <div class="col-md-12">
                    <div class="comentarios">
                        <h1>Discussão: </h1>

                        <div id="disqus_thread"></div>
                        <script>

                            /**
                            *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
                            *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
                            /*
                            var disqus_config = function () {
                            this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
                            this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
                            };
                            */
                            (function () { // DON'T EDIT BELOW THIS LINE
                                var d = document, s = d.createElement('script');
                                s.src = 'https://www-investidorinovador-com-br.disqus.com/embed.js';
                                s.setAttribute('data-timestamp', +new Date());
                                (d.head || d.body).appendChild(s);
                            })();
                        </script>
                        <noscript><a href="https://disqus.com/?ref_noscript"></a></noscript>


                    </div>
                </div>
            </div>
        </div>

    </form>


    <script id="dsq-count-scr" src="//www-investidorinovador-com-br.disqus.com/count.js" async></script>
</body>
</html>
