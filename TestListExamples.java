import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testFilterRightEnd() {
    List<String> left = Arrays.asList("moon", "door", "leap", "Moon");
    List<String> right = Arrays.asList("mooon", "moon", "Mooon");
    List<String> leftfilter = ListExamples.filter(left, new IsMoon());
    List<String> rightfilter = ListExamples.filter(right, new IsMoon());
    List<String> leftExpected = Arrays.asList("moon", "Moon");
    List<String> rightExpected = Arrays.asList("moon");
    assertEquals(leftExpected, leftfilter);
    assertEquals(rightExpected, rightfilter);
  }
}
