package generalModule;

import java.util.Random;

public class GetAnimation {
	public static String random() {
		Random rand = new Random();
		return SiteConstants.ANIMATE[rand.nextInt(SiteConstants.ANIMATE.length)];
	}
}
