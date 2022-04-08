using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FRS_File_App {
    public partial class MainMaster : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack)
            {
                DataLoad();
            }
        }


        protected void DataLoad()
        {
            DataTable dtreport = GRIDTABLE_export();

            foreach (DataRow row in dtreport.Rows)
            {
                string content = "";
                char padding = Convert.ToChar("0");


                string month = row["MONTH"].ToString().Replace("-", "");
                string year = row["YEAR"].ToString().Replace("-", "");
                string flag = row["flag"].ToString().Replace("-", "");

                if (month == "APR" && year == "2022" && flag == "1")
                {
                    ASPxNavBar1.Items[8].Visible = true;
                }

                else if (month == "MAY" && year == "2022" && flag == "1")
                {
                    ASPxNavBar1.Items[9].Visible = true;
                }
                else if (month == "JUN" && year == "2022" && flag == "1")
                {
                    ASPxNavBar1.Items[10].Visible = true;
                }

                else if (month == "JUL" && year == "2022" && flag == "1")
                {
                    ASPxNavBar1.Items[11].Visible = true;
                }

                else if (month == "AUG" && year == "2022" && flag == "1")
                {
                    ASPxNavBar1.Items[12].Visible = true;
                }

                else if (month == "SEP" && year == "2022" && flag == "1")
                {
                    ASPxNavBar1.Items[13].Visible = true;
                }

                else if (month == "OCT" && year == "2022" && flag == "1")
                {
                    ASPxNavBar1.Items[14].Visible = true;
                }

                else if (month == "NOV" && year == "2022" && flag == "1")
                {
                    ASPxNavBar1.Items[15].Visible = true;
                }

                else if (month == "DEC" && year == "2022" && flag == "1")
                {
                    ASPxNavBar1.Items[16].Visible = true;
                }
            }

        }


        protected DataTable GRIDTABLE_export()
        {
            DataTable table = new DataTable();
            string query = "SELECT * FROM " + "[dbo].[ReportSettings]"  ;


            string constr = ConfigurationManager.ConnectionStrings["FRS_Pen_ReductionConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);


                            table = dt;
                        }
                    }
                }
            }

            return table;
        }


    }
}