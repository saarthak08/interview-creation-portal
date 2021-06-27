package com.sg.interview_creation_portal.data.dto;

import com.sg.interview_creation_portal.config.DateTimeFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.NotNull;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InterviewDTO {

    private Long id;

    @NotNull(message = "startTiming is required")
    private Long startTiming;

    @NotNull(message = "endTiming is required")
    private Long endTiming;

    @NotNull(message = "intervieweeId is required")
    private Long intervieweeId;

    @NotNull(message = "interviewerId is required")
    private Long interviewerId;

    @AssertTrue(message = "startTiming & endTiming are not valid")
    private boolean isTimeValid() {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DateTimeFormat.dateFormat);
        SimpleDateFormat timeFormat = new SimpleDateFormat(DateTimeFormat.timeFormat);
        Date startDate = new Date(this.startTiming);
        String startDateString = dateFormat.format(startDate);

        Date endDate = new Date(this.endTiming);
        String endDateString = dateFormat.format(endDate);

        Date startTime = new Date(this.startTiming);
        String startTimeString = timeFormat.format(startTime);

        Date endTime = new Date(this.endTiming);
        String endTimeString = timeFormat.format(endTime);

        try {
            startDate = dateFormat.parse(startDateString);
            endDate = dateFormat.parse(endDateString);
            startTime = timeFormat.parse(startTimeString);
            endTime = timeFormat.parse(endTimeString);

        } catch (ParseException e) {
            return false;
        }

        if ((endDate.compareTo(startDate) != 0)) {
            return false;
        }

        final int hourDifference = Integer.parseInt(endTimeString.substring(0, 2)) - Integer.parseInt(startTimeString.substring(0, 2));
        if (endTime.compareTo(startTime) <= 0 || (hourDifference < 1)) {
            return false;
        }

        if ((hourDifference == 1)
                && (Integer.parseInt(endTimeString.substring(3)) < Integer.parseInt(startTimeString.substring(3)))) {
            return false;
        }

        return true;
    }

}
