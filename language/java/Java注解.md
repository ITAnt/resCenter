# Java 注解

注解
     @StringDef 代替枚举类型  @IntDef

```java
@StringDef({SUNDAY, MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY})
@Retention(RetentionPolicy.SOURCE)
public @interface WeekDays {}

@WeekDays String currentDay = SUNDAY;

public void setCurrentDay(@WeekDays String currentDay) {
	this.currentDay = currentDay;
}
 
@WeekDays
public String getCurrentDay() {
	return currentDay;
}
```
