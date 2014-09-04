using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Runtime.InteropServices;
using Amazon;
using Amazon.SQS;
using Amazon.SQS.Model;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;

namespace AmazonPoller
{
    class Program
    {
        private const int MF_BYCOMMAND = 0x00000000;
        public const int SC_CLOSE = 0xF060;

        [DllImport("user32.dll")]
        public static extern int DeleteMenu(IntPtr hMenu, int nPosition, int wFlags);

        [DllImport("user32.dll")]
        private static extern IntPtr GetSystemMenu(IntPtr hWnd, bool bRevert);

        [DllImport("kernel32.dll", ExactSpelling = true)]
        private static extern IntPtr GetConsoleWindow();

        static void Main(string[] args)
        {
            // disable close button to prevent accidental window closing
            DeleteMenu(GetSystemMenu(GetConsoleWindow(), false), SC_CLOSE, MF_BYCOMMAND);
            
            // check if we're already running
            bool createdNew = true;
            Mutex mutex = new Mutex(true, "WO_AmazonPoller_Started", out createdNew);
            if (!createdNew)
            {
                Console.WriteLine("AmazonPoller is ALREADY running");
                Console.WriteLine("Press enter to exit");
                Console.ReadLine();
                return;
            }
 
            try
            {
                Console.CancelKeyPress += delegate(object sender, ConsoleCancelEventArgs e)
                {
                    DebugLog.Write("!!!!!!! Control-C pressed");

                    //e.Cancel = true;
                };

                AmazonPoller poller = new AmazonPoller();
            }
            catch (Exception e)
            {
                DebugLog.Write("some major SHIT happened: " + e.ToString());
            }

            DebugLog.Write("Press Enter to continue...");
            //Console.Read();
        }
    }
}
