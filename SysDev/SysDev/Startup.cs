﻿using System;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin;
using Owin;
using SysDev.Models;

[assembly: OwinStartupAttribute(typeof(SysDev.Startup))]
namespace SysDev
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            /*
            var context = new ApplicationDbContext();
            Console.WriteLine("Initial seeding");
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
            var userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));


            if (!roleManager.RoleExists("SuperAdmin"))
            {
                //Create Admin rool   
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole { Name = "SuperAdmin" };
                roleManager.Create(role);

                //Create a Admin super user who will maintain the website                  
                var profile = new UserProfile
                {
                    FirstName = "Glenn",
                    LastName = "Tumampil",
                    MiddleName = "Mendez",
                    MaritalStatus = "Single",
                    Address = "Makati City",
                    Gender = "Male",
                    ContactNo = "09770975881",
                    CompanyName = "Bluebell corp",
                    DateCreated = DateTime.Now.ToString(),
                    CompanyId = "10000010"

                };
                context.UserProfiles.Add(profile);


                var user = new ApplicationUser
                {
                    UserName = "suadmin2017",
                    Email = "SuAdmin@Bluebell.com",
                    UserProfileId = profile.Id,
                    UserProfile = profile,
                    PhoneNumber = profile.ContactNo,
                    Status = "Active"
                };

                string userPWD = "admin123";

                var chkUser = userManager.Create(user, userPWD);

                //Add default User to Role Admin   
                if (chkUser.Succeeded)
                {
                    var result1 = userManager.AddToRole(user.Id, "SuperAdmin");

                }
            }

            // creating Creating Manager role    
            if (!roleManager.RoleExists("Manager"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole { Name = "Manager" };
                roleManager.Create(role);

            }

            // creating Creating Employee role    
            if (!roleManager.RoleExists("Employee"))
            {
                var role = new Microsoft.AspNet.Identity.EntityFramework.IdentityRole { Name = "Employee" };
                roleManager.Create(role);

            }
            */
        }
    }
}
