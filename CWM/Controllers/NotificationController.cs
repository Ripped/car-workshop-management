using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using CWM.Models;
using Microsoft.AspNetCore.Mvc;

namespace CWM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class NotificationController : BaseCrudController<Notification, NotificationSearch, NotificationInsertUpdate, NotificationInsertUpdate>
    {
        public NotificationController(IMapper mapper, INotificationRepository notificationRepository) : base(mapper, notificationRepository) { }
    }
}
