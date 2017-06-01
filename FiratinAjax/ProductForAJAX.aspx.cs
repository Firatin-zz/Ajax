using Newtonsoft.Json;
using System;
using System.Data;
using System.Web.Services;

public partial class ProductForAJAX : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string UrunList()
    {
        DataTable dtUrunler = Baglanti.GetDataTable("select*from Tbl_Genel_Kayitlar order by id desc");

        return JsonConvert.SerializeObject(dtUrunler);
    }
    [WebMethod]
    public static string UrunDuzenle(int id, string Baslik, string Etiket, string Description)
    {
        DataRow dr = Baglanti.GetDataRow("update Tbl_Genel_Kayitlar set Baslik='" + Baslik + "',etiket='" + Etiket + "',Description='" + Description + "' where id=" + id + "");

        return "success";
    }
    [WebMethod]
    public static string UrunEkle(string Baslik, string Etiket, string Description)
    {
        Baglanti.ExecuteQuery("insert into Tbl_Genel_Kayitlar (Baslik,Etiket,Description) values ('" + Baslik + "','" + Etiket + "','" + Description + "')");

        return "success";
    }
}