﻿using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CWM.Controllers
{
    [Authorize]
    public abstract class BaseCrudController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch>
    where T : Base
    where TSearch : BaseSearch
    where TInsert : class
    where TUpdate : class
    {
        protected readonly IMapper Mapper;
        private readonly IBaseRepository<T, TSearch> BaseRepository;

        protected BaseCrudController(
            IMapper mapper,
            IBaseRepository<T, TSearch> baseRepository
            ) : base(baseRepository)
        {
            Mapper = mapper;
            BaseRepository = baseRepository;
        }

        /// <remarks>Insert new object</remarks>
        [HttpPost]
        public virtual async Task<T> Insert([FromBody] TInsert insert)
             => await BaseRepository.InsertAsync(Mapper.Map<T>(insert));

        /// <remarks>Update object by Id</remarks>
        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id, [FromBody] TUpdate update)
            => await BaseRepository.UpdateAsync(Mapper.Map<T>(update, opt => opt.AfterMap((src, dest) => dest.Id = id)));

        /// <remarks>Delete object by Id</remarks>
        [HttpDelete("{id}")]
        public virtual async Task<bool> Delete(int id)
            => await BaseRepository.DeleteAsync(id);
    }
}
