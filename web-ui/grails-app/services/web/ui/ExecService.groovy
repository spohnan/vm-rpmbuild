package web.ui

import org.apache.commons.exec.CommandLine
import org.apache.commons.exec.DefaultExecuteResultHandler
import org.apache.commons.exec.DefaultExecutor
import org.apache.commons.exec.PumpStreamHandler
import org.apache.commons.exec.ExecuteWatchdog
import org.apache.commons.exec.ShutdownHookProcessDestroyer

class ExecService {

    public static final String ERROR_VALUE = "ERROR"

    String execAndWaitWithTimeout(CommandLine command, long processTimeout, File workingDirectory) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream()
        DefaultExecuteResultHandler resultHandler = new DefaultExecuteResultHandler()
        DefaultExecutor executor = new DefaultExecutor()
        PumpStreamHandler streamHandler = new PumpStreamHandler(outputStream);

        executor.setStreamHandler(streamHandler)
        executor.setWatchdog(new ExecuteWatchdog(processTimeout))
        executor.setWorkingDirectory(workingDirectory)
        executor.setProcessDestroyer(new ShutdownHookProcessDestroyer())


        int retVal
        String output = ""

        try {

            executor.execute(command,resultHandler)
            resultHandler.waitFor()

            retVal = resultHandler.getExitValue();
            if(executor.isFailure(retVal)) {
                output = ERROR_VALUE
            } else {
                output = outputStream.toString()
            }

        } catch(Exception e) {
            log.error("External process failed, cmdline: ${command.toString()}'", e)
        }

        return output
    }
}
