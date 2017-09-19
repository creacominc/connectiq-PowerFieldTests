using Toybox.Application as App;


class PowerFieldViewMock extends PowerFieldView
{

    function initialize()
    {
        var app = Application.getApp();
        app.setProperties();
        PowerFieldView.initialize();
    }


    function getHearts()
    {
            return m_hearts;
    }
    function getPower3s()
    {
            return m_powerIntervalSet.getAverage(0);
    }
    function getPower30s()
    {
            return m_powerIntervalSet.getAverage(1);
    }
    function getPower120s()
    {
            return m_powerIntervalSet.getAverage(2);
    }
    function getPower300s()
    {
            return m_powerIntervalSet.getAverage(3);
    }
    function getPower1200s()
    {
            return m_powerIntervalSet.getAverage(4);
    }
    function getPower3600s()
    {
            return m_powerIntervalSet.getAverage(5);
    }
    function getPower7200s()
    {
            return m_powerIntervalSet.getAverage(6);
    }
    function getPeak3s()
    {
            return m_powerIntervalSet.getPeak(0);
    }
    function getPeak30s()
    {
            return m_powerIntervalSet.getPeak(1);
    }
    function getPeak120s()
    {
            return m_powerIntervalSet.getPeak(2);
    }
    function getPeak300s()
    {
            return m_powerIntervalSet.getPeak(3);
    }
    function getPeak1200s()
    {
            return m_powerIntervalSet.getPeak(4);
    }
    function getPeak3600s()
    {
            return m_powerIntervalSet.getPeak(5);
    }
    function getPeak7200s()
    {
           return m_powerIntervalSet.getPeak(6);
    }

}
