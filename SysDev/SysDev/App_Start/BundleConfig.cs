﻿using System.Web;
using System.Web.Optimization;

namespace SysDev
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                "~/Content/bootstrap.css",
                "~/admin-lte/css/AdminLTE.css",
                "~/admin-lte/css/skins/skin-blue.css",
                "~/Content/font-awesome.min.css",
                "~/Content/sweetalert2/dist/sweetalert.min.css",
                "~/Content/plugins/iCheck/square/blue.css",
                "~/Content/Site.css"));

            bundles.Add(new ScriptBundle("~/admin-lte/js").Include(
                "~/admin-lte/js/app.js",
                "~/Content/sweetalert2/dist/sweetalert.min.js",
                "~/Content/plugins/iCheck/icheck.min.js",
                "~/admin-lte/plugins/fastclick/fastclick.js"));
        }
    }
}
