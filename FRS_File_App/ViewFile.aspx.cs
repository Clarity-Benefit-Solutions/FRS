using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FRS_File_App
{
    public partial class ViewFile : System.Web.UI.Page
    {
        string filepath = System.Web.Configuration.WebConfigurationManager.AppSettings["exportFilePath"].ToString();
        string payment_filepath = System.Web.Configuration.WebConfigurationManager.AppSettings["export_payment"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataLoad();
            }
        }


        protected void DataLoad()
        {
            if (Request.QueryString["Export"] != null)
            {
                string export = Request.QueryString["Export"].ToString();
                if (export == "Raw")
                {
                    fileManager.Settings.RootFolder = filepath + "\\Raw\\";
                }
                else if (export == "Life")
                {
                    fileManager.Settings.RootFolder = filepath + "\\life\\";
                }
                else if (export == "Medical")
                {
                    fileManager.Settings.RootFolder = filepath + "\\medical\\";
                }
                else if (export == "Payment")
                {
                    fileManager.Settings.RootFolder = payment_filepath ;
                }
            }
        }
             
    }
}