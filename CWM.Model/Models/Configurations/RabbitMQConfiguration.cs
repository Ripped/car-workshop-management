﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models.Configurations
{
    public class RabbitMQConfiguration
    {
        public string Host { get; set; } = string.Empty;

        public int Port { get; set; }

        public string User { get; set; } = string.Empty;

        public string Password { get; set; } = string.Empty;

        public string Virtualhost { get; set; } = string.Empty;
    }
}
