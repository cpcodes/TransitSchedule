x "h:\My Documents\Visual Studio 2010\Projects\NextBusDisplay\Documentation\NextBusDisplay.dir"
x "h:\My Documents\Visual Studio 2010\Projects\NextBusDisplay\Documentation\NextBusDisplayTests.cs"

http://localhost:2448/Default.aspx?stops=399,27000-398,28000-Metrolink-Amtrak
http://localhost:2448/Admin.aspx?stops=399,27000-398,28000-Metrolink-Amtrak
As Scheduled = Platform 1 - South End


.Net 4: Easy way to dynamically create List<Tuple<…>> results
http://stackoverflow.com/a/2013397/69039
string Test[] = { "Route=398, Stop=28000, Platform=As Scheduled" }
List<string> ErrResult = new List<string>("Route=398, Stop=28000, Platform=As Scheduled");

// Test Set Platform Override Expiration Date
void dl_SelectedIndexChanged(object sender, EventArgs e)
{
    DropDownList dl = (DropDownList)sender;

    if (dl.ID.StartsWith("PlatformOverrideId"))
    {
        PlatformOverride po = GetPlatformOverride(int.Parse(dl.ID.Substring(19)));
        po.Platform = dl.SelectedValue;
        // Update The UpdateUntil Value To Be When The Next Departure Time Is Happening.
        Int32 times = GetNextScheduleTime(GetDaysEnumeration());
        po.OverrideUntil = MinutesToDate(times.ToString());
        dc.SubmitChanges();

    }
}

DataClasses1DataContext dc = new DataClasses1DataContext();
private Int32 GetNextScheduleTime(List<string> DaysList)
{
    // At Most The List Will Have Three Entries At This Time. The GetDaysEnumeration() Is Modified To Always Return The Same Number Of Items
    string[] aDays = DaysList.ToArray();

    // This assumes that the Coaster trains stop before midnight. Sprinter trains go until shortly after midnight.
    // Fix: Add Minutes after midnight to midnight time in DB so 12:01AM = 1441
    // SELECT t.DepartTime FROM StaticTrains t WHERE t.Train = 'Coaster' AND t.Days IN (@tdays) AND CAST(t.DepartTime AS INT) > fn_MinutesSinceMidnight
    try
    {
        var results = (from t in dc.StaticTrains
                       where (t.Train == "Coaster")
                         && (Convert.ToInt32(t.DepartTime) > MinutesSinceMidnight())
                         && (t.Days == aDays[0] || t.Days == aDays[1] || t.Days == aDays[2])
                       orderby Convert.ToInt32(t.DepartTime)
                       select Convert.ToInt32(t.DepartTime));
        return results.First();
    }
    catch
    {
        return "0000";
    }
}
