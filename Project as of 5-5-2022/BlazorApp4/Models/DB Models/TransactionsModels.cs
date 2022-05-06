using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BlazorApp4.Models
{
    public class TransactionModels
    {
        public int TransactionID { get; set; }
        public double TransactionAmount { get; set; }
        public string BusinessName { get; set; }
        public string BusinessLocation { get; set; }
        public string ChargeType { get; set; }
        public string TransactionType { get; set; }
        public int TAccountID { get; set; }
        public string TCustomerID { get; set; }

        public string Safety { get; set; }
    }
}
