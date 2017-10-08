using Toybox.Application as App;

class PowerFieldTestsApp extends App.AppBase
{

    protected var m_view;
    protected var m_properties;

    function initialize()
    {
        AppBase.initialize();
    }

    function setProperties(properties)
    {
        m_properties = properties;
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
        //System.print("getProperty(" + key + ") == ");
        //System.println(m_properties.get(key));
        return m_properties.get(key);
    }

}