<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="PaymentProcess.aspx.cs" Inherits="FRS_File_App.PaymentProcess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function popupwindow(url, title, w, h) {
            var left = (screen.width / 2) - (w / 2);
            var top = (screen.height / 2) - (h / 2);
            return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no,      menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        }
    </script>

     
    <div class="row">
        <div class="col-lg-1"></div>
        <div class="col-lg-10">
            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout" Width="100%" ClientInstanceName="FormLayout">
            <Items>
                <dx:LayoutGroup Width="100%" Caption="FRS Payment File" ColCount="2">
                 
                    <Items>
                        <dx:LayoutItem Caption="Payment Method" VerticalAlign="Middle"> 
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxComboBox runat="server" ID="cmb_type" Theme="Moderno" Width="100%"
                                                     OnSelectedIndexChanged="cmb_type_OnSelectedIndexChanged" 
                                                     AutoPostBack="True" >
         
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Check Number" VerticalAlign="Middle"  >

                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox runat="server" ID="txt_check_num" Theme="Moderno" Caption="" Width="100%">
                                        <ValidationSettings SetFocusOnError="true">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="User Email" VerticalAlign="Middle" ColSpan="2">

                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxTextBox runat="server" ID="txt_email" Theme="Moderno" Width="100%">
                                        <ValidationSettings SetFocusOnError="true">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Post Mark Date" VerticalAlign="Middle">

                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxDateEdit ID="de_pm" runat="server" EditFormat="Custom" Width="100%" Theme="Moderno">
                                        <TimeSectionProperties>
                                            <TimeEditProperties EditFormatString="MM/dd/yyyy" />
                                        </TimeSectionProperties>
                                        <ValidationSettings SetFocusOnError="true">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Deposite Date" VerticalAlign="Middle">

                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxDateEdit ID="de_DepositDate" runat="server" EditFormat="Custom" Width="100%" Theme="Moderno">

                                        <TimeSectionProperties>
                                            <TimeEditProperties EditFormatString="MM/dd/yyyy" />
                                        </TimeSectionProperties>
                                        <ValidationSettings SetFocusOnError="true">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Member Event Date">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <dx:ASPxDateEdit ID="de_MemberEventDate" runat="server" EditFormat="Custom" Width="100%" Theme="Moderno">
                                        <TimeSectionProperties>
                                            <TimeEditProperties EditFormatString="MM/dd/yyyy" />
                                        </TimeSectionProperties>
                                        <ValidationSettings SetFocusOnError="true">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                          <dx:LayoutItem Caption="Member Event Date" ShowCaption="false">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Medical CSV Upload" VerticalAlign="Middle">

                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <asp:FileUpload runat="server" ID="upload_medical" AllowMultiple="False" />

                                    <asp:RegularExpressionValidator
                                        ID="FileUpLoadValidator" runat="server" ForeColor="Red"
                                        ErrorMessage="Upload csv only."
                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.csv|.CSV)$"
                                        ControlToValidate="upload_medical">  
                                    </asp:RegularExpressionValidator>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Life CSV Upload" VerticalAlign="Middle">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <asp:FileUpload runat="server" ID="upload_life" AllowMultiple="False" />

                                    <asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator1" runat="server" ForeColor="Red"
                                        ErrorMessage="Upload csv only."
                                        ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.csv|.CSV)$"
                                        ControlToValidate="upload_life">  
                                    </asp:RegularExpressionValidator>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" VerticalAlign="Middle" Paddings-PaddingTop="20px" CssClass="lastItem" ColSpan="2">
                            
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <asp:Label runat="server" ID="lbl_error" CssClass="text-success"></asp:Label>
                                    <dx:ASPxButton runat="server" ID="btn_process_paymentfile" Text="PROCESS PAYMENT"
                                        OnClick="btn_process_paymentfile_OnClick" Theme="Moderno"  ></dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
            </Items>
        </dx:ASPxFormLayout> 
     
            <div id="result" runat="server">

                <div class="align-content-center" style="width: 100%; text-align: center; margin-top: 30px;margin-bottom: 20px ">
                    <dx:ASPxLabel runat="server" ID="lbl_life" CssClass="text-info" Font-Bold="True" Font-Size="14" Theme="MetropolisBlue"
                                  />
                </div>
                <dx:ASPxGridView ID="grid_life" runat="server" AutoGenerateColumns="False"
                                 OnPageIndexChanged="ASPxGridView1_OnPageIndexChanged" Theme="Moderno"
                    Width="100%" Visible="False">

                    <SettingsPager PageSize="20" />
                    <Paddings Padding="0px" />
                    <Border BorderWidth="0px" />
                    <BorderBottom BorderWidth="1px" />
                  
                    <%-- DXCOMMENT: Configure ASPxGridView's columns in accordance with datasource fields 								--%>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Member SSN" VisibleIndex="0" FixedStyle="Left">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Payee SSN" VisibleIndex="1" FixedStyle="Left">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Payee Name" VisibleIndex="2" FixedStyle="Left">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Pay Date [MMYYYY]" VisibleIndex="3" Width="150px" FixedStyle="Left">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataColumn Caption="Deduction Amount" VisibleIndex="10" Width="150px">
                            <SettingsHeaderFilter>
                                <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                            </SettingsHeaderFilter>
                            <DataItemTemplate>
                                <dx:ASPxLabel ID="lbl_Amount_Due" runat="server"
                                              Text='<%# string.Format("{0:C}",Eval("Deduction Amount")) %>'>
                                </dx:ASPxLabel>

                            </DataItemTemplate>
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataTextColumn FieldName="Module Code" VisibleIndex="5" Width="150px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Deduction Organization Code" VisibleIndex="5" Width="150px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Member Date of Death" VisibleIndex="5" Width="150px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Agency Number" VisibleIndex="5" Width="150px">
                        </dx:GridViewDataTextColumn>


                    </Columns>
                <%--    <Settings ShowFooter="true" />
                    <TotalSummary>
                        <dx:ASPxSummaryItem SummaryType="Custom" FieldName="Deduction_Amount" ShowInColumn="Deduction_Amount" DisplayFormat="Total Deduction: {0:c}" ValueDisplayFormat="{0}:c" />
                    </TotalSummary>--%>
                </dx:ASPxGridView>
                <div class="align-content-center" style="width: 100%; text-align: center; margin-top: 30px;margin-bottom: 20px ">
                    <dx:ASPxLabel runat="server" ID="lbl_medical" CssClass="text-info" Font-Bold="True" Font-Size="14" Theme="MetropolisBlue"/>
                </div>


                <dx:ASPxGridView ID="grid_medical" runat="server" AutoGenerateColumns="False" OnPageIndexChanged="ASPxGridView2_OnPageIndexChanged" Theme="Moderno"
                    Width="100%" Visible="False">
                    <SettingsPager PageSize="20" />
                    <Paddings Padding="0px" />
                    <Border BorderWidth="0px" />
                    <BorderBottom BorderWidth="1px" />
                   
                  <Columns>
                        <dx:GridViewDataTextColumn FieldName="Member SSN" VisibleIndex="0" FixedStyle="Left">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Payee SSN" VisibleIndex="1" FixedStyle="Left">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Payee Name" VisibleIndex="2" FixedStyle="Left">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Pay Date [MMYYYY]" VisibleIndex="3" Width="150px" FixedStyle="Left">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataColumn Caption="Deduction Amount" VisibleIndex="10" Width="150px">
                            <SettingsHeaderFilter>
                                <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                            </SettingsHeaderFilter>
                            <DataItemTemplate>
                                <dx:ASPxLabel ID="lbl_Amount_Due" runat="server"
                                    Text='<%# string.Format("{0:C}",Eval("Deduction Amount")) %>'>
                                </dx:ASPxLabel>

                            </DataItemTemplate>
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataTextColumn FieldName="Module Code" VisibleIndex="5" Width="150px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Deduction Organization Code" VisibleIndex="5" Width="150px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Member Date of Death" VisibleIndex="5" Width="150px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Agency Number" VisibleIndex="5" Width="150px">
                        </dx:GridViewDataTextColumn>


                    </Columns>
                </dx:ASPxGridView>
                
                <dx:ASPxButton runat="server" ID="btn_test" Text="test button" OnClick="btn_test_OnClick" Theme="Moderno" ValidationGroup="alfred"  Visible="False"></dx:ASPxButton>
                <dx:ASPxGridView runat="server" ID="gridtest" Visible="False">
                    <SettingsPager PageSize="200"></SettingsPager>
                </dx:ASPxGridView>
            </div>
        </div>
        <div class="col-lg-1"></div>
    </div>
</asp:Content>
