using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using DevExpress.Data;
using DevExpress.Web;
using DevExpress.Web.Internal;
using Image = System.Web.UI.WebControls.Image;

namespace FRS_File_App
{
    public partial class PaymentProcess : System.Web.UI.Page
    {
        string payment_filepath =
            System.Web.Configuration.WebConfigurationManager.AppSettings["export_payment"].ToString();

        string medical_import =
            System.Web.Configuration.WebConfigurationManager.AppSettings["import_medical"].ToString();

        string life_import = System.Web.Configuration.WebConfigurationManager.AppSettings["import_life"].ToString();

        string tablename = System.Web.Configuration.WebConfigurationManager.AppSettings["tablename"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadList();


            }

        }

        const string UploadDirectory = "~/Import/";

        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            e.CallbackData = SavePostedFile(e.UploadedFile);
        }

        protected string SavePostedFile(UploadedFile uploadedFile)
        {
            if (!uploadedFile.IsValid)
                return string.Empty;
            string fileName = Path.GetRandomFileName();
            string fullFileName = CombinePath(fileName);

            return fileName;
        }

        protected string CombinePath(string fileName)
        {
            return Path.Combine(Server.MapPath(UploadDirectory), fileName);
        }


        protected void LoadList()
        {
            cmb_type.Items.Clear();
            cmb_type.Items.Add(new ListEditItem("Check"));
            cmb_type.Items.Add(new ListEditItem("Money Order"));
            cmb_type.Items.Add(new ListEditItem("Non-Cash Non-Remitted"));
            cmb_type.Items.Add(new ListEditItem("Customer ACH Transaction Payment"));
            cmb_type.Items.Add(new ListEditItem("Scheduled Payment*"));
            cmb_type.Items.Add(new ListEditItem("Zero Amount Subsidy Coupon"));
            cmb_type.SelectedIndex = 0;

            string first_dayMonth = DateTime.Now.Month.ToString() + "/01/" + DateTime.Now.Year.ToString();
            de_DepositDate.Date = Convert.ToDateTime(first_dayMonth).AddDays(-1);
            de_MemberEventDate.Date = Convert.ToDateTime(first_dayMonth).AddDays(-1);
            de_pm.Date = Convert.ToDateTime(first_dayMonth).AddDays(-1);

        }

        protected void cmb_type_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            txt_check_num.Text = "";
            if (cmb_type.SelectedIndex == 0)
            {
                txt_check_num.Text = "";
                txt_check_num.Visible = true;
            }
            else
            {
                txt_check_num.Text = "N/A";
                txt_check_num.Visible = false;

            }
        }


        protected void btn_process_paymentfile_OnClick(object sender, EventArgs e)
        {

            if (saveFile())
            {


                grid_life.Visible = true;
                grid_medical.Visible = true;
                DataLoad();
               

                string url = "ViewFile.aspx?export=Payment";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window",
                    "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');",
                    true);
            }


        }



        protected bool saveFile()
        {
            bool uploaded = false;

            if (upload_medical.HasFile && upload_life.HasFile)
            {

                upload_medical.SaveAs(medical_import + "\\medical_import.csv");
                upload_life.SaveAs(life_import + "\\life_import.csv");
                lbl_error.Text = "File Uploaded: " + upload_medical.FileName + " & " + upload_medical.FileName;
                lbl_error.CssClass = "text-success";

                uploaded = true;
            }
            else
            {
                lbl_error.Text = "Please Upload both Medical and Life csv files.";
                lbl_error.CssClass = "text-danger";
            }

            return uploaded;
        }

        #region direct file write

        protected void directWrite()
        {
            string batchnumber = "BID" + DateTime.Now.ToString("MM/dd/yyyy").Replace("/", "");
            string ConnectionString = ConfigurationManager.ConnectionStrings["FRS_Pen_ReductionConnectionString"]
                .ConnectionString;
            string Sql =
                "INSERT INTO [dbo].[FRS_Batch]( [BatchID], [PM_DATE],[DEPOSITE_DATE],[MEMBER_EVENTDATE],[Payment_Method],[Check_Num] ,[User_Email]) VALUES ('" +
                batchnumber + "', '" + de_pm.Date + "', '" + de_DepositDate.Date + "', '" + de_MemberEventDate.Date +
                "', '" +
                cmb_type.SelectedItem.Text.Trim() + "', '" + txt_check_num.Text.Replace(" ", "").Trim() + "','" +
                txt_email.Text.Trim() + "')";
            using (SqlConnection oSqlConnection = new SqlConnection(ConnectionString))
            {
                SqlCommand oSqlCommand = new SqlCommand(Sql, oSqlConnection);
                try
                {
                    oSqlConnection.Open();
                    oSqlCommand.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message.ToString());
                }
                finally
                {
                    oSqlCommand.Dispose();
                    oSqlConnection.Close();
                    oSqlConnection.Dispose();
                }
            }


            //writeFile(GRIDTABLE(), payment_filepath + "\\Import\\Payment\\PaymentFile.csv");
            //string url = "ViewFile.aspx?export=Payment";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);
        }

        protected DataTable GRIDTABLE()
        {
            DataTable table = new DataTable();



            string query = " SELECT * FROM [dbo].[PAYMENTFILE]";
            string constr = ConfigurationManager.ConnectionStrings["FRS_Pen_ReductionConnectionString"]
                .ConnectionString;
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


                            if (cmb_type.SelectedIndex == 0)
                            {
                                table = dt;
                                //ASPxGridView1.DataSource = dt;
                                //ASPxGridView1.DataBind();
                            }
                        }
                    }
                }
            }

            return table;
        }

     
        #endregion


        protected void ASPxGridView1_OnPageIndexChanged(object sender, EventArgs e)
        {
            var view = sender as ASPxGridView;
            if (view == null) return;
            var pageIndex = view.PageIndex;
            grid_life.PageIndex = pageIndex;
            DataLoad();
        }

        protected void ASPxGridView2_OnPageIndexChanged(object sender, EventArgs e)
        {
            var view = sender as ASPxGridView;
            if (view == null) return;
            var pageIndex = view.PageIndex;
            grid_medical.PageIndex = pageIndex;
            DataLoad();
        }

        protected void DataLoad()
        {


            DataTable dt = ReadCsvFile(life_import + "\\life_import.csv");
            
            double sum = 0.00;
            foreach (DataRow row in dt.Rows)
            {
                string stringValue = row[6].ToString();

                double d;
                if (double.TryParse(stringValue, out d))
                    sum += d;
            }

            grid_life.DataSource = dt;
            grid_life.DataBind();
            lbl_life.Text = "LIFE.CSV RESULT" + "\n" + "Deduction Total: $" + sum;
            //string lifepayment = payment_filepath + "\\life_payment.csv";
            //paymentfile(dt, lifepayment);


            DataTable dt_medical = ReadCsvFile(medical_import + "\\medical_import.csv");

            double sum_medical = 0.00;
            foreach (DataRow row in dt_medical.Rows)
            {
                string stringValue = row[6].ToString();

                double d;
                if (double.TryParse(stringValue, out d))
                    sum_medical += d;
            }

            grid_medical.DataSource = dt_medical;
            grid_medical.DataBind();
            lbl_medical.Text = "MEDICAL.CSV RESULT" + "\n" + "Deduction Total: $" + sum_medical;
            string medical_life_payment = payment_filepath + "\\medical_life_payment.csv";
            paymentfile(dt_medical, dt, medical_life_payment);
        }

       
        #region Read CSV

        public DataTable ReadCsvFile(string FileSaveWithPath)
        {

            DataTable dtCsv = new DataTable();
            string Fulltext;


            using (StreamReader sr = new StreamReader(FileSaveWithPath))
            {
                while (!sr.EndOfStream)
                {
                    Fulltext = sr.ReadToEnd().ToString(); //read full file text  
                    string[] rows = Fulltext.Split('\n'); //split full file text into rows  
                    for (int i = 0; i < rows.Count(); i++)
                    {

                        DataRow dr = dtCsv.NewRow();
                        string[] rowValues = rows[i].Split(',');


                        if (i == 0)
                        {

                            for (int j = 0; j < rowValues.Count(); j++)
                            {
                                dtCsv.Columns.Add(rowValues[j].ToString().Trim()); //add headers  
                                //Response.Write(rowValues[j]);
                            }
                        }

                        else
                        {


                            if (!string.IsNullOrEmpty(rowValues[0].ToString()) && !string.IsNullOrEmpty(rowValues[1].ToString()))
                            {
                                if (rowValues.Count() > 10)
                                {
                                    for (int k = 0; k < rowValues.Count(); k++)
                                    {
                                        if (k == 5)
                                        {
                                            dr[k - 1] += ", " + rowValues[k].ToString().Replace("\"", "").Replace("$", "")
                                                .Trim();
                                        }

                                        if (k == 6)
                                        {
                                            dr[k - 1] += ", " + rowValues[k].ToString().Replace("\"", "").Replace("$", "")
                                                .Trim();
                                        }
                                        else if (k == 7)
                                        {
                                            double t = Convert.ToDouble(rowValues[k].ToString().Replace("\"", "")
                                                .Replace("$", "").Trim()) * 1000;

                                            double tt = Convert.ToDouble(rowValues[k + 1].ToString().Replace("\"", "")
                                                .Replace("$", "").Trim());

                                            dr[k - 1] = t + tt;
                                        }
                                        else if (k == 9)
                                        {
                                            dr[k - 2] = rowValues[k].ToString().Replace("\"", "").Replace("$", "").Trim();
                                        }
                                        else if (k == 10)
                                        {
                                            dr[k - 2] = rowValues[k].ToString().Replace("\"", "").Replace("$", "").Trim();
                                        }
                                        else if (k == 11)
                                        {
                                            dr[k - 2] = rowValues[k].ToString().Replace("\"", "").Replace("$", "").Trim();
                                        }
                                        else if (k < 5)
                                        {
                                            dr[k] = rowValues[k].ToString().Replace("\"", "").Replace("$", "").Trim();
                                        }

                                    }
                                }
                                else
                                {

                                    for (int k = 0; k < rowValues.Count(); k++)
                                    {
                                        if (k == 5)
                                        {
                                            dr[k - 1] += ", " + rowValues[k].ToString().Replace("\"", "").Replace("$", "")
                                                .Trim();
                                        }
                                        else if (k == 7)
                                        {
                                            dr[k - 1] = Convert.ToDouble(rowValues[k].ToString().Replace("\"", "")
                                                .Replace("$", "").Trim());
                                        }
                                        else if (k > 5 && k <= 9)
                                        {
                                            dr[k - 1] = rowValues[k].ToString().Replace("\"", "").Replace("$", "").Trim();
                                        }
                                        else if (k < 5)
                                        {
                                            dr[k] = rowValues[k].ToString().Replace("\"", "").Replace("$", "").Trim();
                                        }

                                    }
                                }

                                dtCsv.Rows.Add(dr); //add other rows 
                                                    //split each row with comma to get individual values  
                            }
                        }



                    }

                }

            }

            return dtCsv;
        }


        #endregion

        protected void btn_test_OnClick(object sender, EventArgs e)
        {
            DataTable dt =
                ReadCsvFile("\\\\vmware-host\\Shared Folders\\Documents\\FRS_Pen_Reduction\\20210930440 medical.csv");

            double sum = 0.00;
            foreach (DataRow row in dt.Rows)
            {
                string stringValue = row[6].ToString();

                double d;
                if (double.TryParse(stringValue, out d))
                    sum += d;
            }

            //Response.Write(sum);
            gridtest.Visible = true;
            gridtest.DataSource = dt;
            gridtest.DataBind();

        }

        #region payment file

        protected void paymentfile(DataTable dtDataTable, DataTable dtDataTable_life, string strFilePath)
        {
            List<string>  both_life_medical = new List<string>();
            StreamWriter sw = new StreamWriter(strFilePath, false);
            // Version 1.2
            sw.Write("[VERSION], 1.2");
            string today = DateTime.Now.ToString("yyyyMMddHHmmssFFF");
           
            sw.Write(sw.NewLine);
            foreach (DataRow dr in dtDataTable.Rows)
            {
                if (!string.IsNullOrEmpty(dr[3].ToString()))
                {
                    string medical_ssn = dr[3].ToString();
                    double medical_amount = Convert.ToDouble(dr[6].ToString());
                    foreach (DataRow dr_life in dtDataTable_life.Rows)
                    {
                        
                        if (!string.IsNullOrEmpty(dr_life[3].ToString()))
                        {
                            string life_ssn = dr_life[3].ToString();
                            double life_amount = Convert.ToDouble(dr_life[6].ToString());
                            if (medical_ssn.Trim().Replace("-","") == life_ssn.Trim().Replace("-", ""))
                            {
                                double s = life_amount + medical_amount;
                                sw.Write(today); //batch id
                                sw.Write(",");
                                sw.Write(de_pm.Date.ToString("MM/dd/yyyy")); //post mark date
                                sw.Write(",");
                                sw.Write(s.ToString()); //Amount
                                sw.Write(",");
                                sw.Write(dr[3].ToString()); //SSN
                                sw.Write(",");
                                sw.Write(dr[3].ToString()); //SSN
                                sw.Write(",");
                                sw.Write(GetUntilOrEmpty(dr[4].ToString()).Trim()); // last
                                sw.Write(",");
                                sw.Write(dr[4].ToString().Split(',').Last().Trim()); // first
                                sw.Write(",");
                                sw.Write(de_MemberEventDate.Date.ToString("MM/dd/yyyy")); // member event date
                                sw.Write(",");
                                sw.Write("MONTHLY");// frequency
                                sw.Write(",");
                                sw.Write(getMemberID(dr[3].ToString()));// member id
                                sw.Write(",");
                                sw.Write("1");// member type
                                sw.Write(",");
                                sw.Write(txt_check_num.Text);// check number
                                sw.Write(",");
                                sw.Write(de_DepositDate.Date.ToString("MM/dd/yyyy"));// deposit date
                                sw.Write(",");
                                sw.Write(DateTime.Now.Date.ToString("MM/dd/yyyy")); // entered datetime 
                                sw.Write(",");
                                sw.Write(txt_email.Text); // entered username
                                sw.Write(",");
                                sw.Write(cmb_type.SelectedItem.Text); // payment method 
                                sw.Write(sw.NewLine);

                                both_life_medical.Add(life_ssn);
                            }
                            //else
                            //{
                                #region
                                //if (!tempList.Contains(life_ssn))
                                //{
                                //    sw.Write(today); //batch id
                                //    sw.Write(",");
                                //    sw.Write(de_pm.Date.ToString("MM/dd/yyyy")); //post mark date
                                //    sw.Write(",");
                                //    sw.Write((life_amount)); //Amount
                                //    sw.Write(",");
                                //    sw.Write(dr_life[3].ToString()); //SSN
                                //    sw.Write(",");
                                //    sw.Write(dr_life[3].ToString()); //SSN
                                //    sw.Write(",");
                                //    sw.Write(GetUntilOrEmpty(dr_life[4].ToString()).Trim()); // last
                                //    sw.Write(",");
                                //    sw.Write(dr_life[4].ToString().Split(',').Last().Trim()); // first
                                //    sw.Write(",");
                                //    sw.Write(de_MemberEventDate.Date.ToString("MM/dd/yyyy")); // member event date
                                //    sw.Write(",");
                                //    sw.Write("MONTHLY");// frequency
                                //    sw.Write(",");
                                //    sw.Write(getMemberID(dr_life[3].ToString()));// member id
                                //    sw.Write(",");
                                //    sw.Write("1");// member type
                                //    sw.Write(",");
                                //    sw.Write(txt_check_num.Text);// check number
                                //    sw.Write(",");
                                //    sw.Write(de_DepositDate.Date.ToString("MM/dd/yyyy"));// deposit date
                                //    sw.Write(",");
                                //    sw.Write(DateTime.Now.Date.ToString("MM/dd/yyyy")); // entered datetime 
                                //    sw.Write(",");
                                //    sw.Write(txt_email.Text); // entered username
                                //    sw.Write(",");
                                //    sw.Write(cmb_type.SelectedItem.Text); // payment method
                                //    //sw.Write(",");
                                //    //sw.Write("2");
                                //    sw.Write(sw.NewLine);

                                //    tempList.Add(life_ssn);
                                //}
                                #endregion
                            //}
                        }
                    }

                   
               
                }

            }
            foreach (DataRow dr in dtDataTable.Rows)
            {
                if (!string.IsNullOrEmpty(dr[3].ToString()))
                {
                    string medical_ssn = dr[3].ToString();
                    if (!both_life_medical.Contains(medical_ssn))
                    {
                        double medical_amount = Convert.ToDouble(dr[6].ToString());
                        sw.Write(today); //batch id
                        sw.Write(",");
                        sw.Write(de_pm.Date.ToString("MM/dd/yyyy")); //post mark date
                        sw.Write(",");
                        sw.Write(medical_amount.ToString()); //Amount
                        sw.Write(",");
                        sw.Write(dr[3].ToString()); //SSN
                        sw.Write(",");
                        sw.Write(dr[3].ToString()); //SSN
                        sw.Write(",");
                        sw.Write(GetUntilOrEmpty(dr[4].ToString()).Trim()); // last
                        sw.Write(",");
                        sw.Write(dr[4].ToString().Split(',').Last().Trim()); // first
                        sw.Write(",");
                        sw.Write(de_MemberEventDate.Date.ToString("MM/dd/yyyy")); // member event date
                        sw.Write(",");
                        sw.Write("MONTHLY");// frequency
                        sw.Write(",");
                        sw.Write(getMemberID(dr[3].ToString()));// member id
                        sw.Write(",");
                        sw.Write("1");// member type
                        sw.Write(",");
                        sw.Write(txt_check_num.Text);// check number
                        sw.Write(",");
                        sw.Write(de_DepositDate.Date.ToString("MM/dd/yyyy"));// deposit date
                        sw.Write(",");
                        sw.Write(DateTime.Now.Date.ToString("MM/dd/yyyy")); // entered datetime 
                        sw.Write(",");
                        sw.Write(txt_email.Text); // entered username
                        sw.Write(",");
                        sw.Write(cmb_type.SelectedItem.Text); // payment method 
                        sw.Write(sw.NewLine);
                    } 
                }

            }
            foreach (DataRow dr_life in dtDataTable_life.Rows)
            {

                if (!string.IsNullOrEmpty(dr_life[3].ToString()))
                {
                    string life_ssn = dr_life[3].ToString();
                   
                    if (!both_life_medical.Contains(life_ssn))
                    {
                        double life_amount = Convert.ToDouble(dr_life[6].ToString());
                        sw.Write(today); //batch id
                        sw.Write(",");
                        sw.Write(de_pm.Date.ToString("MM/dd/yyyy")); //post mark date
                        sw.Write(",");
                        sw.Write(life_amount.ToString()); //Amount
                        sw.Write(",");
                        sw.Write(dr_life[3].ToString()); //SSN
                        sw.Write(",");
                        sw.Write(dr_life[3].ToString()); //SSN
                        sw.Write(",");
                        sw.Write(GetUntilOrEmpty(dr_life[4].ToString()).Trim()); // last
                        sw.Write(",");
                        sw.Write(dr_life[4].ToString().Split(',').Last().Trim()); // first
                        sw.Write(",");
                        sw.Write(de_MemberEventDate.Date.ToString("MM/dd/yyyy")); // member event date
                        sw.Write(",");
                        sw.Write("MONTHLY");// frequency
                        sw.Write(",");
                        sw.Write(getMemberID(dr_life[3].ToString()));// member id
                        sw.Write(",");
                        sw.Write("1");// member type
                        sw.Write(",");
                        sw.Write(txt_check_num.Text);// check number
                        sw.Write(",");
                        sw.Write(de_DepositDate.Date.ToString("MM/dd/yyyy"));// deposit date
                        sw.Write(",");
                        sw.Write(DateTime.Now.Date.ToString("MM/dd/yyyy")); // entered datetime 
                        sw.Write(",");
                        sw.Write(txt_email.Text); // entered username
                        sw.Write(",");
                        sw.Write(cmb_type.SelectedItem.Text); // payment method 
                        sw.Write(sw.NewLine); 
                         
                    }
                    
                }
            }
            sw.Close();

        }


        protected string GetUntilOrEmpty(string text, string stopAt = ",")
        {
            if (!String.IsNullOrWhiteSpace(text))
            {
                int charLocation = text.IndexOf(stopAt, StringComparison.Ordinal);

                if (charLocation > 0)
                {
                    return text.Substring(0, charLocation);
                }
            }

            return String.Empty;
        }

        protected string getMemberID(string ssn)
        {
            string memberID = "";

            string query = " SELECT TOP 1 MEMBER_ID FROM " + tablename + " WHERE SSN ='" + ssn+"'";
            string constr = ConfigurationManager.ConnectionStrings["FRS_Pen_ReductionConnectionString"]
                .ConnectionString;
 

            using (SqlConnection sqlConnection = new SqlConnection(constr))
            {
                sqlConnection.Open();
                using (SqlCommand cmd = sqlConnection.CreateCommand())
                {
                    cmd.CommandText = query;
                    cmd.CommandType = CommandType.Text;
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                             

                            memberID = reader["MEMBER_ID"].ToString();
                             
                           
                        }
                    }
                }
            }




            return memberID;
        }
        #endregion
    }



    public class PaymentFileClass
    {
         
        public string Frist { get; set; }
        public string Last { get; set; }
        public string SSN { get; set; }
        public double Amount { get; set; }
    }
}