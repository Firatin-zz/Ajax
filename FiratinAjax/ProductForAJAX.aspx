<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductForAJAX.aspx.cs" Inherits="ProductForAJAX" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="Server">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <style type="text/css">
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">

    <div class="w3-container">
        <h2>Ajax CRUD İşlemleri</h2>
        <div id="div2" class="w3-container w3-teal" style="display: none;">
            İşlemi başarılı!
        </div>
        <div id="div3" class="w3-container w3-red" style="display: none;">
            İşlemi başarısız!
        </div>
        <div class="w3-row">
            <a href="javascript:void(0)" onclick="openCity(event, 'Ürün Listele');" id="tabUrunListele">
                <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">Ürün Listele</div>
            </a>
            <a href="javascript:void(0)" onclick="openCity(event, 'Ürün Ekle');">
                <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">Ürün Ekle</div>
            </a>
            <a href="javascript:void(0)" onclick="openCity(event, 'Kategoriler');">
                <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">Kategoriler</div>
            </a>
        </div>
        <%-----------------------------------------------Ürün Listeleme Tab-----------------------------------------------%>

        <div id="Ürün Listele" class="w3-container city" style="display: none">
            <br>
            <h2>Ürün Listele</h2>
            <div class="content">
                <div id="veriler" class="container">
                </div>
            </div>

        </div>
        <%-----------------------------------------------Ürün Ekleme Tab-----------------------------------------------%>
        <div id="Ürün Ekle" class="w3-container city" style="display: none">
            <h2>Ürün Ekle</h2>
            <%--   <div class="w3-row w3-section">
                <div class="w3-col" style="width: 50px"><i class="w3-xxlarge fa fa-user"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="first" type="text" placeholder="First Name">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width: 50px"><i class="w3-xxlarge fa fa-user"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="last" type="text" placeholder="Last Name">
                </div>
            </div>--%>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width: 50px"><i class="w3-xxlarge fa fa-pencil"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" id="txtBaslik" type="text" placeholder="Başlık">
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width: 50px"><i class="w3-xxlarge fa fa-pencil"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" id="txtEtiket" type="text" placeholder="Etiket">
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width: 50px"><i class="w3-xxlarge fa fa-pencil"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" id="txtDescription" type="text" placeholder="Açıklama">
                </div>
            </div>
            <input type="button" id="btnEkle" value="Ekle" class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding" />
        </div>
        <%-----------------------------------------------Kategori Tab-----------------------------------------------%>

        <div id="Kategoriler" class="w3-container city" style="display: none">
            <h2>Kategoriler</h2>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBodyAlt" runat="Server">
    <script>
        //-------------------------------List--------------------------
        $("#tabUrunListele").click(function () {
            $.ajax({
                type: "POST",
                url: "ProductForAJAX.aspx/UrunList",
                contentType: "application/json; charset=utf-8",
                success: function (veri) {
                    $("#veriler").empty();
                    var gelen = JSON.parse(veri.d);

                    var html = "<table border=\"1\"><tr><th>Urun ID</th><th>Urun</th><th>Etiket</th><th>Description</th><th colspan=\"2\">İşlemler</th></tr>";
                    for (var i = 0; i < gelen.length; i++) {
                        html += "<tr><td><label>" + gelen[i].id + "</label></td><td><label>" + gelen[i].Baslik + "</label></td><td><label>" + gelen[i].Etiket + "</label></td><td><label>" + gelen[i].Description + "</label></td><td><input type=\"button\" itag=\"Edit\" onclick=\"return UrunDuzenle(this);\" value=\"Düzenle\" />";
                    }
                    html += "</table>"
                    $("#veriler").append(html);
                }
            });

        });
        //-----------------------------------Edit-----------------------

        function UrunDuzenle(control) {
            if ($(control).val() == "Düzenle") {
                var i = 0;
                $(control).closest("tr").find("td").each(function (control) {
                    if (i != 0) {

                        if ($(this).find("label").length > 0) {
                            var getValuesOfLabel = $(this).find("label").html();
                            $(this).find("label").hide();
                            $(this).append("<input type=\"text\" value=\"" + getValuesOfLabel + "\" />")
                        }
                    }
                    i++;
                    $(this).find("input[itag='Edit']").val("Kaydet");

                });
            }
            else {
                var id = "",
                Baslik = "",
                Etiket = ""
                Description = "";

                id = $(control).closest("tr").find("td:nth-child(1)").find("label").html();
                Baslik = $(control).closest("tr").find("td:nth-child(2)").find("input").val();
                Etiket = $(control).closest("tr").find("td:nth-child(3)").find("input").val();
                Description = $(control).closest("tr").find("td:nth-child(4)").find("input").val();


                var gonderilenData = {
                    id: id, Baslik: Baslik, Etiket: Etiket, Description: Description
                };
                $.ajax({
                    url: "ProductForAJAX.aspx/UrunDuzenle",
                    type: "Post",
                    data: JSON.stringify(gonderilenData),
                    dataType: "json",
                    contentType: "application/json",
                    success: function (result) {
                        Baslik = $(control).closest("tr").find("td:nth-child(2)").find("input").val();
                        $(control).closest("tr").find("td:nth-child(2)").find("input").remove();
                        $(control).closest("tr").find("td:nth-child(2)").append("<label>" + Baslik + "</label>");

                        Etiket = $(control).closest("tr").find("td:nth-child(3)").find("input").val();
                        $(control).closest("tr").find("td:nth-child(3)").find("input").remove();
                        $(control).closest("tr").find("td:nth-child(3)").append("<label>" + Etiket + "</label>");

                        Description = $(control).closest("tr").find("td:nth-child(4)").find("input").val();
                        $(control).closest("tr").find("td:nth-child(4)").find("input").remove();
                        $(control).closest("tr").find("td:nth-child(4)").append("<label>" + Description + "</label>");

                        $(control).val("Düzenle");

                        $("#div2").fadeIn("slow");
                        $("#div2").fadeToggle(3000);
                        $("#div2").fadeOut("slow");
                    },
                    error: function (result) {
                        $("#div3").fadeIn("slow");
                        $("#div3").fadeToggle(3000);
                        $("#div3").fadeOut("slow");
                    }
                })
            }
        }
        //-----------------------------------Create-----------------------
        $("#btnEkle").click(function () {
            var baslik = $("#txtBaslik").val();
            var etiket = $("#txtEtiket").val();
            var description = $("#txtDescription").val();
            $.ajax({
                type: "Post",
                contentType: "application/json; charset=utf-8",
                url: "ProductForAJAX.aspx/UrunEkle",
                data: "{'Baslik':'" + baslik + "', 'Etiket':'" + etiket + "','Description':'" + description + "'}",
                success: function () {
                    $("#div2").fadeIn("slow");
                    $("#div2").fadeToggle(3000);
                    $("#div2").fadeOut("slow");
                }, error: function () {
                    $("#div3").fadeIn("slow");
                    $("#div3").fadeToggle(3000);
                    $("#div3").fadeOut("slow");
                }

            });
        });

        //-----------------------------------w3 tab----------
        function openCity(evt, cityName) {
            var i, x, tablinks;
            x = document.getElementsByClassName("city");
            for (i = 0; i < x.length; i++) {
                x[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablink");
            for (i = 0; i < x.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" w3-border-red", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.firstElementChild.className += " w3-border-red";
        }
    </script>
</asp:Content>

