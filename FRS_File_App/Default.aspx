<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Main.master" CodeBehind="Default.aspx.cs" Inherits="FRS_File_App._Default" MaintainScrollPositionOnPostback="true" %>


<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function popupwindow(url, title, w, h) {
            var left = (screen.width / 2) - (w / 2);
            var top = (screen.height / 2) - (h / 2);
            return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no,      menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        }
    </script>

    <div class="row">
        <div class="col-sm-1"></div>
        <div class="col-sm-10">
            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout" Width="100%" ClientInstanceName="FormLayout" Theme="Moderno">
                <Items>
                    <dx:LayoutGroup Width="100%" Caption="SEARCH" ColCount="2">

                        <Items>
                            <dx:LayoutItem Caption="INSURANCE TYPE" VerticalAlign="Middle">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_type" Theme="Moderno" Width="100%" OnSelectedIndexChanged="cmb_type_OnSelectedIndexChanged" AutoPostBack="True">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="ORDER BY" VerticalAlign="Middle">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_orderBy" Theme="Moderno" Width="100%" OnSelectedIndexChanged="cmb_orderBy_OnSelectedIndexChanged" AutoPostBack="True">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="NEXT PREMIUM DUE" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxDateEdit ID="dateEdit" runat="server" EditFormat="Custom" Width="100%" AutoPostBack="True" Theme="Moderno" OnDateChanged="dateEdit_OnDateChanged">
                                            <TimeSectionProperties>
                                                <TimeEditProperties EditFormatString="MM/dd/yyyy" />
                                            </TimeSectionProperties>

                                        </dx:ASPxDateEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                           


                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" VerticalAlign="Middle"
                                Paddings-PaddingTop="20px" CssClass="lastItem" ColSpan="2">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButton runat="server" ID="btn_export_csv" Text="RAW DATA CSV" OnClick="btn_export_csv_OnClick" Theme="Moderno"></dx:ASPxButton>
                                        &nbsp;&nbsp;<dx:ASPxButton runat="server" ID="btn_life" Text="LIFE CSV" OnClick="btn_life_OnClick" Theme="Moderno"></dx:ASPxButton>
                                        &nbsp;&nbsp;<dx:ASPxButton runat="server" ID="btn_medical" Text="MEDICAL CSV" OnClick="btn_medical_OnClick" Theme="Moderno"></dx:ASPxButton>
                                        &nbsp;&nbsp;<dx:ASPxButton runat="server" ID="btn_process_paymentfile" Text="PROCESS PAYMENT" OnClick="btn_process_paymentfile_OnClick" Theme="Moderno" Visible="False"></dx:ASPxButton>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
            <br />
            <div style="width: 100%; margin-top: 30px"></div>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" OnPageIndexChanged="ASPxGridView1_OnPageIndexChanged" Theme="Moderno"
                Width="100%">
                <%--  <SettingsAdaptivity AdaptivityMode="HideDataCells" />--%>
                <Settings HorizontalScrollBarMode="Visible" VerticalScrollableHeight="450" VerticalScrollBarMode="Auto" />
                <SettingsPager PageSize="100" />
                <Paddings Padding="0px" />
                <Border BorderWidth="0px" />
                <BorderBottom BorderWidth="1px" />
                <%-- DXCOMMENT: Configure ASPxGridView's columns in accordance with datasource fields --%>
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="MEMBER_ID" VisibleIndex="0" FixedStyle="Left">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="FIRST" VisibleIndex="1" FixedStyle="Left">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="LAST" VisibleIndex="2" FixedStyle="Left">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="SSN" VisibleIndex="3" Width="150px" FixedStyle="Left">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="BILLING_START_DATE" VisibleIndex="4" Width="150px">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="BILLING_FREQUENCY" VisibleIndex="5" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ENROLLED_PLANS" VisibleIndex="6" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="COVERAGE_LEVEL" VisibleIndex="7" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="STATUS" VisibleIndex="8">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="PLAN_CATEGORY" VisibleIndex="10" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="BILLING_TYPE" VisibleIndex="10" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ACCOUNT_TYPE" VisibleIndex="11" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="RATE_TYPE" VisibleIndex="12" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="PREMIUM_DATE" VisibleIndex="12" Width="250px" Caption="Next Premium Due Date">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataColumn Caption="Unallocated Amount($)" VisibleIndex="13" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxLabel ID="lbl_UnallocatedAmount" runat="server" Text='<%# string.Format("{0:C}", Eval("UnallocatedAmount")) %>' DisplayFormatString="C" Theme="Moderno"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Member Owe($)" VisibleIndex="14" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxLabel ID="lbl_MemberOwes" runat="server" Text='<%# string.Format("{0:C}", Eval("MemberOwes")) %>' DisplayFormatString="C" Theme="Moderno"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Current Premium Due($)" VisibleIndex="15" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxLabel ID="lbl_Amount_Due" runat="server" Text='<%#Eval("PLAN_CATEGORY").ToString() =="MEDICAL"? string.Format("{0:C}",Eval("MEDICAL")) :string.Format("{0:C}", Eval("LIFE")) %>' DisplayFormatString="C"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Total Amount Due($)" VisibleIndex="16" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <%--<dx:ASPxLabel ID="lbl_Amount_Due" runat="server" Text='<%#Eval("PLAN_CATEGORY").ToString() =="MEDICAL"? string.Format("{0:C}",Eval("MEDICAL")) :string.Format("{0:C}", Eval("LIFE")) %>' DisplayFormatString="C"></dx:ASPxLabel>--%>
                            <dx:ASPxLabel ID="lbl_Amount_Due2" runat="server" Text='<%#string.Format("{0:C}",Eval("CURRENT_DUE")) %>' DisplayFormatString="C"></dx:ASPxLabel>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>

                </Columns>
            </dx:ASPxGridView>

        </div>
        <div class="col-sm-1"></div>
    </div>



</asp:Content>
