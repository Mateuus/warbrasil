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
        using (var ms = new MemoryStream(Encoding.Unicode.GetBytes(json)))
        {
            var serialiser = new DataContractJsonSerializer(typeof(T));
            return (T)serialiser.ReadObject(ms);
        }
    }

    public static string ToJson<T>(/* this */ T value)
    {
        var serializer = new DataContractJsonSerializer(typeof(T));

        using (var stream = new MemoryStream())
        {
            using (var writer = JsonReaderWriterFactory.CreateJsonWriter(stream, Encoding.UTF8))
            {
                serializer.WriteObject(writer, value);
            }

            return Encoding.UTF8.GetString(stream.ToArray());
        }
    }
}
