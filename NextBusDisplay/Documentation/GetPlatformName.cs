private string GetPlatformName(string id)
{
    DataClasses1DataContext dc = new DataClasses1DataContext();
    var results = from s in dc.StopDisplays
                  where s.StopID == id
                  select s.Description;
    return results.ToString();
}
