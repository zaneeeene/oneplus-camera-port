import brut.androlib.src.SmaliBuilder;
import com.android.tools.smali.dexlib2.Opcodes;
import com.android.tools.smali.dexlib2.writer.builder.DexBuilder;
import com.android.tools.smali.dexlib2.writer.io.FileDataStore;
import java.io.File;

/**
 * Assemble one apktool smali directory into a dex file.
 * Compile against apktool.jar (which contains the shaded smali/dexlib2 classes):
 *   ecj -cp apktool.jar -d /tmp/asm AssembleSmali.java
 * Run:
 *   java -cp /tmp/asm:apktool.jar AssembleSmali <smali-dir> <out.dex> [api]
 */
public class AssembleSmali {
    public static void main(String[] a) throws Exception {
        File dir = new File(a[0]);
        File out = new File(a[1]);
        int api = a.length > 2 ? Integer.parseInt(a[2]) : 29;
        DexBuilder dex = new DexBuilder(new Opcodes(api, 0));
        SmaliBuilder sb = new SmaliBuilder(dir, api);
        collect(dir, dir, sb, dex);
        dex.writeTo(new FileDataStore(out));
        System.out.println("wrote " + out + " " + out.length());
    }
    static void collect(File base, File f, SmaliBuilder sb, DexBuilder dex) throws Exception {
        if (f.isDirectory()) {
            File[] fs = f.listFiles();
            if (fs == null) return;
            for (File c : fs) collect(base, c, sb, dex);
        } else if (f.getName().endsWith(".smali")) {
            sb.buildFile(base.toURI().relativize(f.toURI()).getPath(), dex);
        }
    }
}
