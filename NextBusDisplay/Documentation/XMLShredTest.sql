DECLARE @xml XML
SET @xml =
'<body copyright="All data copyright North County Transit District 2013.">
  <route tag="399" title="Sprinter" scheduleClass="20130401" serviceClass="Friday" direction="Escondido">
    <header>
      <stop tag="27000">SPRINTER Oceanside Transit Center</stop>
      <stop tag="27001">SPRINTER Coast Hwy Station</stop>
      <stop tag="27002">SPRINTER Crouch St Station</stop>
      <stop tag="27003">SPRINTER El Camino Real Station</stop>
      <stop tag="27004">SPRINTER Rancho del Oro Station</stop>
      <stop tag="27005">SPRINTER College Blvd Station</stop>
      <stop tag="27006">SPRINTER Melrose Dr Station</stop>
      <stop tag="27007">SPRINTER Vista Transit Center</stop>
      <stop tag="27008">SPRINTER Civic Center - Vista Station</stop>
      <stop tag="27009">SPRINTER Buena Creek Station</stop>
      <stop tag="27010">SPRINTER Palomar College Station</stop>
      <stop tag="27011">SPRINTER San Marcos Civic Center Station</stop>
      <stop tag="27012">SPRINTER Cal State San Marcos Station</stop>
      <stop tag="27013">SPRINTER Nordahl Rd Station</stop>
      <stop tag="27014_ar">SPRINTER Escondido Transit Center</stop>
    </header>
    <tr blockID="39901_16">
      <stop tag="27000" epochTime="14580000">04:03:00</stop>
      <stop tag="27001" epochTime="14700000">04:05:00</stop>
      <stop tag="27002" epochTime="14820000">04:07:00</stop>
      <stop tag="27003" epochTime="15060000">04:11:00</stop>
      <stop tag="27004" epochTime="15240000">04:14:00</stop>
      <stop tag="27005" epochTime="15420000">04:17:00</stop>
      <stop tag="27006" epochTime="15720000">04:22:00</stop>
      <stop tag="27007" epochTime="15960000">04:26:00</stop>
      <stop tag="27008" epochTime="16140000">04:29:00</stop>
      <stop tag="27009" epochTime="16500000">04:35:00</stop>
      <stop tag="27010" epochTime="16800000">04:40:00</stop>
      <stop tag="27011" epochTime="16980000">04:43:00</stop>
      <stop tag="27012" epochTime="17160000">04:46:00</stop>
      <stop tag="27013" epochTime="17460000">04:51:00</stop>
      <stop tag="27014_ar" epochTime="17760000">04:56:00</stop>
    </tr>
    <tr blockID="39902_16">
      <stop tag="27000" epochTime="16380000">04:33:00</stop>
      <stop tag="27001" epochTime="16500000">04:35:00</stop>
      <stop tag="27002" epochTime="16620000">04:37:00</stop>
      <stop tag="27003" epochTime="16860000">04:41:00</stop>
      <stop tag="27004" epochTime="17040000">04:44:00</stop>
      <stop tag="27005" epochTime="17220000">04:47:00</stop>
      <stop tag="27006" epochTime="17520000">04:52:00</stop>
      <stop tag="27007" epochTime="17760000">04:56:00</stop>
      <stop tag="27008" epochTime="17940000">04:59:00</stop>
      <stop tag="27009" epochTime="18300000">05:05:00</stop>
      <stop tag="27010" epochTime="18600000">05:10:00</stop>
      <stop tag="27011" epochTime="18780000">05:13:00</stop>
      <stop tag="27012" epochTime="18960000">05:16:00</stop>
      <stop tag="27013" epochTime="19260000">05:21:00</stop>
      <stop tag="27014_ar" epochTime="19560000">05:26:00</stop>
    </tr>
</route>
</body>'
/*
SELECT tag, epochTime
FROM @xml.value
--  Query to select records from Xml column
--  http://www.sqlservercentral.com/Forums/Topic793276-21-1.aspx
SELECT r.value('@Value','int')
FROM Job
CROSS APPLY JobXml.nodes('/Job/TimeID') AS x(r)
*/

-- Select Data From XML in MS SQL Server (T-SQL)
-- http://geekswithblogs.net/DougLampe/archive/2011/03/16/select-data-from-xml-in-ms-sql-server-t-sql.aspx
--  <li><a href="xml/ManipulatingXmlDataInSqlServer.htm"                      >Manipulating XML Data in SQL Server</a></li>
-- https://www.simple-talk.com/sql/database-administration/manipulating-xml-data-in-sql-server/
