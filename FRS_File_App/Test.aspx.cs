using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FRS_File_App
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataLoad();
            }
        }

        protected void DataLoad()
        {

            WringML(GRIDTABLE_export(), "@E:\\Documentation\\RP140_441_IRC_FOR_EXPORT.txt", 1);
        }


        protected DataTable GRIDTABLE_export()
        {
            DataTable table = new DataTable();
            string query = "SELECT * FROM [dbo].[Total Wex Payment]";


            string constr = ConfigurationManager.ConnectionStrings["Script_Testing"].ConnectionString;
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
        protected void WringML(DataTable dtDataTable, string strFilePath, int type)
        {
            StreamWriter sw = new StreamWriter(strFilePath, false);

            int count = 0;
            double total = 0;

            foreach (DataRow row in dtDataTable.Rows)
            {
                string content = "";
                char padding = Convert.ToChar("0");
                if (type == 0) // medical
                {


                    string ssn = row["SSN"].ToString().Replace("-", "").PadRight(9, padding);
                    string medical = string.Format("{0:C}", row["CURRENT_DUE"].ToString()).Replace("$", "").Replace(" ", "").Replace(".", "").PadLeft(11, padding);
                    content = "RP140 440 " + ssn + " " + medical;

                    double local_total = 0;
                    double.TryParse(row["CURRENT_DUE"].ToString().Replace("$", "").Replace(" ", "").Replace(".", ""), out local_total);
                    total += local_total;
            }
                else // life
            {

                string ssn = row["SSN"].ToString().Replace("-", "").PadRight(9, padding);
                string life = string.Format("{0:C}", row["CURRENT_DUE"].ToString()).Replace("$", "").Replace(" ", "").Replace(".", "").PadLeft(11, padding);
                content = "RP140 441 " + ssn + " " + life;


                double local_total = 0;
                double.TryParse(row["CURRENT_DUE"].ToString().Replace("$", "").Replace(" ", "").Replace(".", ""), out local_total);
                total += local_total;
            }

            sw.Write(content);
                sw.Write(sw.NewLine);

                count++;
            }

            sw.Write("*****" + count.ToString().PadLeft(6, '0') + total.ToString().PadLeft(11, '0'));
            sw.Close();
        }



    }
}