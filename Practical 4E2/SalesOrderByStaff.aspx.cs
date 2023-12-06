using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Practical_4E2
{
    public partial class SalesOrderByStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            sdsOrder.SelectParameters["EmployeeID"].DefaultValue =
                ddlName.SelectedValue;

            sdsOrder.SelectParameters["Year"].DefaultValue =
                rblYear.SelectedValue;
        }
    }
}