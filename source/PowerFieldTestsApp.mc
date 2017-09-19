using Toybox.Application as App;

class PowerFieldTestsApp extends App.AppBase
{

    protected var m_view;
    protected var m_properties;

    function initialize()
    {
        AppBase.initialize();
    }

    function setProperties()
    {
        m_properties = {
            "Time0" => 3,
            "Target0" => 923,
            "Time1" => 30,
            "Target1" => 549,
            "Time2" => 60,
            "Target2" => 431,
            "Time3" => 240,
            "Target3" => 283,
            "Time4" => 1200,
            "Target4" => 236,
            "Time5" => 3600,
            "Target5" => 184,
            "Time6" => 7200,
            "Target6" => 152
        };
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    //! Return the initial view of your application here
    function getInitialView()
    {
        var app = Application.getApp();
        m_view = new PowerFieldViewMock();
        return [ m_view ];
    }

    function setProperty(key, value)
    {
        m_properties.put(key, value);
    }

    function getProperty(key)
    {
        return m_properties.get(key);
    }

}