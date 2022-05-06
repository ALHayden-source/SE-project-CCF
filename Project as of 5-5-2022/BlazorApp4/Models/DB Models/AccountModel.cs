using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BlazorApp4.Models
{
    public class AccountModel
    {
        public int AccountID { get; set; }
        public string AccountType { get; set; }
        public string AccountBalance { get; set; }
        public int CustomerID { get; set; }

    }
}
