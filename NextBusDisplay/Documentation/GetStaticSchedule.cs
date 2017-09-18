private void GetStaticSchedule(Schedule schedule)
{
    int LayoverMinutes = -5;
    List<string> days = GetDaysEnumeration();
    int minuteNow = (DateTime.Now.Hour * 60) + DateTime.Now.Minute;
    DataClasses1DataContext dc1 = new DataClasses1DataContext();

    schedule.Departure = "Tomorrow";
    schedule.Departure2 = "Tomorrow";
    schedule.Arrival = "Tomorrow";
    schedule.Arrival2 = "Tomorrow";

    // By Default The Values Will Always Be Schedule Estimated Times Will Override The Schedule
    var staticTrains = (from x in dc1.StaticTrains
                       where x.Train == schedule.RouteType.ToString()
                          && Convert.ToInt32(x.DepartTime) >= minuteNow
                          && x.Direction.Contains(schedule.Direction)
                          && days.Contains(x.Days)
                       orderby Convert.ToInt32(x.DepartTime) ascending
                       select x).Take(2);
    int isFirst = 0;
    foreach (StaticTrain statictrain in staticTrains)
    {
        if (isFirst == 0)
        {
            schedule.Departure = (DateTime.Parse(DateTime.Now.ToShortDateString()).AddMinutes(Convert.ToInt32(statictrain.DepartTime))).ToShortTimeString();
            schedule.Arrival = (Convert.ToDateTime(schedule.Departure).AddMinutes(LayoverMinutes)).ToShortDateString();
            isFirst = 1;
        }
        else
        {
            schedule.Departure2 = (DateTime.Parse(DateTime.Now.ToShortDateString()).AddMinutes(Convert.ToInt32(statictrain.DepartTime))).ToShortTimeString();
            schedule.Arrival2 = (Convert.ToDateTime(schedule.Departure2).AddMinutes(LayoverMinutes)).ToShortDateString();
        }
    }
}

            // By Default The Values Will Always Be Schedule Estimated Times Will Override The Schedule

