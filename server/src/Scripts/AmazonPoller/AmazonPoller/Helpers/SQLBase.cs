using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Web;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Configuration;

namespace AmazonPoller
{
    public class SQLBase
    {
        string server = "";
        string user = "";
        string pass = "";
        string workdb = "gameid_v1";

        SqlConnection conn_ = null;

        // time when connection was lost
        public DateTime lostTime_ = new DateTime(2000, 1, 1);

        public SQLBase()
        {
            server = "db1.thewarinc.com,11433";
            user = "game_api_user";
            pass = "b2agrickw";
        }

        ~SQLBase()
        {
            Disconnect();
        }

        public bool IsConnected()
        {
            return conn_ != null;
        }

        public bool Connect()
        {
            Disconnect();

            if (pass.Length == 0)
                throw new ArgumentException("no password in sql");

            string str = String.Format(
                "user id={0};" +
                "password={1};" +
                "server={2};" +
                "database={3};" +
                "Trusted_Connection=false;" +
                "connection timeout=30",
                user,
                pass,
                server,
                workdb
                );

            try
            {
                SqlConnection c = new SqlConnection(str);
                c.Open();

                conn_ = c;
            }
            catch (Exception)
            {
                lostTime_ = DateTime.Now;

                throw new ApiExitException("SQL Connect failed");
                //return false;
            }

            return true;
        }

        public void Disconnect()
        {
            if (conn_ != null)
            {
                conn_.Close();
                conn_ = null;
            }
        }

        public SqlDataReader Select(SqlCommand sqcmd)
        {
            try
            {
                sqcmd.Connection = conn_;
                SqlDataReader reader = sqcmd.ExecuteReader();
                return reader;
            }
            catch (SqlException e)
            {
                throw new ApiExitException("SQL fail: " + e.Message);
            }
            catch (InvalidOperationException)
            {
                // close connection and rethrow exception
                conn_.Close();
                conn_ = null;

                lostTime_ = DateTime.Now;
                throw;
            }
        }
    }
}