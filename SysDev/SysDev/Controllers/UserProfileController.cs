﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using SysDev.Models;

namespace SysDev.Controllers
{
    [Authorize]
    public class UserProfileController : Controller
    {
        private ApplicationDbContext _context;

        public UserProfileController()
        {
            _context = new ApplicationDbContext();
        }

        protected override void Dispose(bool disposing)
        {
            _context.Dispose();
        }

        // GET: UserProfile
        public ActionResult Index()
        {
            var users = _context.UserProfiles.ToList();
            var accounts = _context.Users.ToList();

            var useraccount = new UserProfileViewModel
            {
                UserProfiles = users,
                Accounts = accounts
            };
            return View(useraccount);
        }

        public ActionResult Details(int id)
        {
            var profile = _context.UserProfiles.SingleOrDefault(p => p.Id == id);

            if (profile == null)
                return HttpNotFound();

            return View(profile);
        }

        public ActionResult Create()
        {
            return View();
        }

        public ActionResult UpdateStatus(int id)
        {
            var account = _context.Users.SingleOrDefault(a => a.UserProfileId == id);
            var user = _context.UserProfiles.SingleOrDefault(u => u.Id == account.UserProfileId);
            if (account != null && user != null)
            {
                account.Status = account.Status == "Active" ? "Inactive" : "Active";
                ReportsController.AddAuditTrail("Update User",
                    "User named " + user.FirstName + " " + user.LastName + " was set to " + account.Status,
                    User.Identity.GetUserId());
                _context.SaveChanges();
            }
            return RedirectToAction("Index", "UserProfile");
        }

        public ActionResult Edit(int id)
        {
            var profile = _context.UserProfiles.SingleOrDefault(p => p.Id == id);
            var account = _context.Users.SingleOrDefault(p => p.UserProfileId == id);

            if (profile == null)
                return HttpNotFound();

            var prof = new AddUserViewModel
            {
                Profile = profile,
                Account = account
            };

            return View(prof);
        }

        [HttpPost]
        public ActionResult Save(AddUserViewModel model)
        {
            if (model.Profile.Id == 0)
            {
                model.Profile.DateCreated = DateTime.Now.ToString("MMM-dd-yyyy hh:mm tt");
                _context.UserProfiles.Add(model.Profile);
                _context.SaveChanges();

                var userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(_context));
                var user = new ApplicationUser
                {
                    UserName = model.Account.UserName,
                    UserProfileId = model.Profile.Id,
                    UserProfile = model.Profile,
                    Email = model.Account.Email,
                    Status = "Active"
                };

                var chkUser = userManager.Create(user, "password1");
                //Add default User to Role Admin   
                if (chkUser.Succeeded)
                {
                    var result1 = userManager.AddToRole(user.Id, "SuperAdmin");

                }
                ReportsController.AddAuditTrail("Add User",
                    model.Profile.FirstName + " " + model.Profile.LastName + " has been added.",
                    User.Identity.GetUserId());
            }
            else
            {
                var profile = _context.UserProfiles.SingleOrDefault(p => p.Id == model.Profile.Id);
                //TryUpdateModel(prifle);
                if (profile != null)
                {
                    profile.FirstName = model.Profile.FirstName;
                    profile.LastName = model.Profile.LastName;
                    profile.MiddleName = model.Profile.MiddleName;

                }


                var account = _context.Users.SingleOrDefault(a => a.UserProfileId == model.Profile.Id);
                if (account != null)
                {
                    account.Email = model.Account.Email;
                    account.UserName = model.Account.UserName;
                }
                _context.SaveChanges();
                ReportsController.AddAuditTrail("Update User",
                    model.Profile.FirstName + " " + model.Profile.LastName + "'s information was Updated",
                    User.Identity.GetUserId());
            }

            return RedirectToAction("Index", "UserProfile");
        }

        public ActionResult Delete(int id)
        {
            var profile = _context.UserProfiles.SingleOrDefault(p => p.Id == id);

            if (profile == null)
                return HttpNotFound();

            _context.UserProfiles.Remove(profile);
            _context.SaveChanges();

            ReportsController.AddAuditTrail("Update User",
               "User named " + profile.FirstName + " " + profile.LastName + " was Deleted",
                User.Identity.GetUserId());

            return RedirectToAction("Index", "UserProfile");
        }
    }
}