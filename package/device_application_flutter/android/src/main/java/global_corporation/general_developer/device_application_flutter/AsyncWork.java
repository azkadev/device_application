package global_corporation.general_developer.device_application_flutter;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

class AsyncWork {

    private final ThreadPoolExecutor threadPoolExecutor;
    private final BlockingQueue<Runnable> workQueue;

    AsyncWork() {
        this.workQueue = new LinkedBlockingQueue<>();
        this.threadPoolExecutor = new ThreadPoolExecutor(1, 1, 1, TimeUnit.SECONDS, workQueue);
    }

    void run(Runnable runnable) {
        threadPoolExecutor.execute(runnable);
    }

    void stop() {
        threadPoolExecutor.shutdown();
    }
}
