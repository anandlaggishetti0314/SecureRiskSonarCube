package com.wellness.enums;

public enum FolderPath {
	INSTANCE("E:\\store\\user profiles");

	public final String path;

	FolderPath(String path) {
		this.path = path;
	}
}
