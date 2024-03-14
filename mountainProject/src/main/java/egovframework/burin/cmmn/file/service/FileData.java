package egovframework.burin.cmmn.file.service;

public class FileData {
	private byte[] fileBytes;
    private String fileExtension;

    public FileData(byte[] fileBytes, String fileExtension) {
        this.fileBytes = fileBytes;
        this.fileExtension = fileExtension;
    }

    public byte[] getFileBytes() {
        return fileBytes;
    }

    public String getFileExtension() {
        return fileExtension;
    }
    
}
