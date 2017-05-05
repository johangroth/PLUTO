package uk.org.linuxgrotto;
/*
 * binhex
 * Copyright 2017 Johan Groth
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * Created by jgroth on 04/05/17.
 */
public class BinToHex {

    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Input file name must be given.");
            System.exit(0);
        }

        String inputFile = args[0];
        Path p = FileSystems.getDefault().getPath("", args[0]);
        byte[] byteArray = null;
        try {
            byteArray = Files.readAllBytes(p);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String nl = System.getProperty("line.separator");

        StringBuilder hexFileData = new StringBuilder();
        hexFileData.append("$");
        hexFileData.append(String.format("%02X", byteArray[1]));
        hexFileData.append(String.format("%02X", byteArray[0]));
        hexFileData.append(nl);

        StringBuilder data = new StringBuilder();

        for (int i = 2; i < byteArray.length; i++) {
            data.append(String.format("%02X", byteArray[i]));
            data.append(" ");

            if (i % 16 == 0) {
                data.append(nl);
            }
        }
        data.append(nl);
        hexFileData.append(data);
        hexFileData.append("*");
        String outputFile = inputFile + ".hex";
        try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(outputFile))) {
            bufferedWriter.write(hexFileData.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
