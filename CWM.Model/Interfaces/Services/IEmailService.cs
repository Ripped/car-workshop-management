﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Interfaces.Services
{
    public interface IEmailService
    {
        Task SendErrorMailAsync(string message);
    }
}
