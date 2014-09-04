using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace AmazonPoller
{
    public class DebugLog
    {
        static public string LOG_FNAME = null;

        static public void Write(string fmt, params object[] prm)
        {
            if (LOG_FNAME == null)
            {
                System.IO.Directory.CreateDirectory("logs");

                LOG_FNAME = string.Format("logs\\AmazonPoller-{0}{1:00}{2:00}-{3:00}{4:00}.txt", 
                    DateTime.Now.Year,
                    DateTime.Now.Month,
                    DateTime.Now.Day,
                    DateTime.Now.Hour,
                    DateTime.Now.Minute);
                Write("Loggin started to " + LOG_FNAME);
            }

            string msg = string.Format("{0:00}.{1:00} {2:00}:{3:00}:{4:00} ",
                DateTime.Now.Month,
                DateTime.Now.Day,
                DateTime.Now.Hour,
                DateTime.Now.Minute, DateTime.Now.Second);

            try
            {
                if (prm == null || prm.Length == 0)
                    msg += fmt;
                else
                    msg += string.Format(fmt, prm);
            }
            catch
            {
                msg += "!!!!! bad string.Format failed for " + fmt;
            }

            Console.WriteLine(msg);

            try
            {
                using (StreamWriter w = File.AppendText(LOG_FNAME))
                {
                    w.WriteLine(msg);
                    w.Close();
                }
            }
            catch { }

        }
    }
}
