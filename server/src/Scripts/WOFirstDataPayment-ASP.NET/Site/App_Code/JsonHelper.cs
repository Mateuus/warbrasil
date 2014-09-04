using System;
using System.Collections.Generic;
using System.Web;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;

public class JSONHelper
{
    public static T Deserialise<T>(string json)
    {
        /*
        T obj = Activator.CreateInstance<T>();
        MemoryStream ms = new MemoryStream(Encoding.Unicode.GetBytes(json));
        DataContractJsonSerializer serialiser = new DataContractJsonSerializer(obj.GetType());
        ms.Close();
        return obj;
         * */
        using (MemoryStream ms = new MemoryStream(Encoding.Unicode.GetBytes(json)))
        {
            DataContractJsonSerializer serialiser = new DataContractJsonSerializer(typeof(T));
            return (T)serialiser.ReadObject(ms);
        }
    }

    public static string ToJson<T>(/* this */ T value)
    {
        DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(T));

        using (MemoryStream stream = new MemoryStream())
        {
            using (System.Xml.XmlDictionaryWriter writer = JsonReaderWriterFactory.CreateJsonWriter(stream, Encoding.UTF8))
            {
                serializer.WriteObject(writer, value);
            }

            return Encoding.UTF8.GetString(stream.ToArray());
        }
    }
}
