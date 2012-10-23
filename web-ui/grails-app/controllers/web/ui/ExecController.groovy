package web.ui

import org.apache.commons.exec.CommandLine

class ExecController {

    def execService

    def DEFAULT_PROCESS_TIMEOUT = 5000;
    def DEFAULT_WORKING_DIR = new File("/tmp")

   def fetch() {
       // FIXME: Determine base path through app metadata grails.serverUrl?
       def templateHome = "http://localhost:8080/web-ui/templates"
       def retVal = "${templateHome}/${params.template}.handlebars".toURL().text
       render(text: retVal, contentType: "text/plain", encoding: "UTF-8")
   }

    def test() {
        def retVal = runCmd("ls -l")
        if (retVal.equals(ExecService.ERROR_VALUE)) {
            retVal = "nope"
        }
        render(text: retVal, contentType: "text/plain", encoding: "UTF-8")
    }

    def appinfo() {
        def retVal = """
        {
            "appliance": {
                "version": "12.1",
                "updated": "2012-10-12T21:43Z",
                "local_changelist": [
                    { "name": "file1.txt"},
                    { "name": "file2.txt"},
                    { "name": "file3.txt"},
                    { "name": "file4.txt"},
                    { "name": "file5.txt"},
                    { "name": "file6.txt"},
                    { "name": "file7.txt"}
                ]
            },
            "repos": [
                { "name": "repo1" },
                { "name": "repo2" }
            ]
        }
        """

        render(text: retVal, contentType: "application/json", encoding: "UTF-8")
    }

    private String runCmd(String cmdLine) {
        execService.execAndWaitWithTimeout(CommandLine.parse(cmdLine), DEFAULT_PROCESS_TIMEOUT, DEFAULT_WORKING_DIR)
    }
}
