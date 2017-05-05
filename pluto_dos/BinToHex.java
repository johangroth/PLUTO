import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * Created by jgroth on 04/05/17.
 */
public class BinToHex {

    public static void main(String[] args) {
        Path p = FileSystems.getDefault().getPath("", args[0]);
        byte[] byteArray = null;
        try {
            byteArray = Files.readAllBytes(p);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Path binHexFile = FileSystems
        StringBuilder sb = new StringBuilder();
        for (byte bb : byteArray) {
            System.out.println(String.format("%02X", bb));
        }
    }
}
