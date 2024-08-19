package kr.or.ddit.controller.mailController;

public class Test01 {
		
	private String name = "1";
	
	public void test(String name) {
		String name2 = "2";
		String name3 = "3";
		
		new Thread() {
			
			private String name = "3";
			
			public void run() {
				String name = "4";
				String name2 = "5";
				
				System.out.println();
				System.out.println();
				System.out.println();
			}
		}.start();
	}
	public static void main(String[] args) {
		new Test01().test("name");;
		new Test01().test("name2");;
	}
}
