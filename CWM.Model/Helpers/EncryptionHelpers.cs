using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Helpers
{
    public static class EncryptionHelpers
    {
        public static string Hash(string clearText)
        {
            var clearBytes = Encoding.Unicode.GetBytes(clearText);

            using (var md5 = MD5.Create())
            {
                var builder = new StringBuilder();

                foreach (var b in md5.ComputeHash(clearBytes))
                    builder.Append(b.ToString("x2").ToLower());

                return builder.ToString();
            }
        }
    }
}
