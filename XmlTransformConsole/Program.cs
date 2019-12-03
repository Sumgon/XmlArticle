using System;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;

namespace XmlTransformConsole
{
    public class Program
    {
        public static void Main(string[] args)
        {
            string xmlFilePath = @"D:\OneDrive\Resources\Xml\XmlArticle\XmlArticle\Example\Example.xml";
            string xsltPath = @"D:\OneDrive\Resources\Xml\XmlArticle\XmlArticle\Transform\Article.xslt";
            string htmlPath = @"D:\OneDrive\Resources\Xml\XmlArticle\XmlArticle\Example\Example.html";
            if (File.Exists(xmlFilePath) && File.Exists(xsltPath))
            {
                XPathDocument myXPathDoc = new XPathDocument(xmlFilePath);
                XslCompiledTransform myXslTrans = new XslCompiledTransform();
                myXslTrans.Load(xsltPath);
                XmlTextWriter myWriter = new XmlTextWriter(htmlPath, null);
                myXslTrans.Transform(myXPathDoc, null, myWriter);
                Console.WriteLine("Success!");
            }
            else
            {
                Console.WriteLine("Please fill the three paths and ensure xml and xslt file exist!");
            }
        }



    }
}
