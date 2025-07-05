using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models.Searches;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Repositories
{
    public class NotificationRepository : BaseRepository<Notification, Core.Models.Notification, NotificationSearch>, INotificationRepository { 
    public NotificationRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }

    protected override IQueryable<Notification> AddInclude(IQueryable<Notification> query, NotificationSearch? search = null)
    {
        if (search is null)
            return base.AddInclude(query, search);

        if (!string.IsNullOrWhiteSpace(search.Name))
            query = query.Where(x => x.Name.ToLower().Contains(search.Name.ToLower()));

            if (search.IncludeUser)
                query = query.Include(x => x.User);

            return query;
    }
}
}
