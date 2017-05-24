<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="erro.aspx.cs" Inherits="Blog.Web.erro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>Ops</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,300,500,600,700" rel="stylesheet" />

    <style type="text/css">
    
        html, body {
            height: 100%;
            width: 100%;
        }
        
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hidMensagem" runat="server" />
        
        <div class="container" style="background: #EBEBEB" >
            <div class="row" >
                <h1>Ops, Algo de Errado Aconteceu</h1>
                <p>Trabalhamos para que isso não aconteça, mas as vezes é invevitável, entre em contato e te ajudaremos o mais rápido possível !</p>
            </div>
        </div>

    </form>

    
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>
