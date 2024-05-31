package web.gvarni.servletfinal;

import java.io.Serializable;
import java.math.BigDecimal; // Use BigDecimal instead of float/double for currency

public class Event implements Serializable {

    private int eventId;
    private String eventCategory;
    private String eventName;
    private java.sql.Date eventDate; // Use java.sql.Date for SQL dates
    private java.sql.Time eventTime;  // Use java.sql.Time for SQL times
    private String eventLocation;
    private String imgUrl;
    private BigDecimal seatTicketPrice;
    private BigDecimal standingTicketPrice;

    public Event() {}

    // Getters and Setters for each field

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getEventCategory() {
        return eventCategory;
    }

    public void setEventCategory(String eventCategory) {
        this.eventCategory = eventCategory;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public java.sql.Date getEventDate() {
        return eventDate;
    }

    public void setEventDate(java.sql.Date eventDate) {
        this.eventDate = eventDate;
    }

    public java.sql.Time getEventTime() {
        return eventTime;
    }

    public void setEventTime(java.sql.Time eventTime) {
        this.eventTime = eventTime;
    }

    public String getEventLocation() {
        return eventLocation;
    }

    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public BigDecimal getSeatTicketPrice() {
        return seatTicketPrice;
    }

    public void setSeatTicketPrice(BigDecimal seatTicketPrice) {
        this.seatTicketPrice = seatTicketPrice;
    }

    public BigDecimal getStandingTicketPrice() {
        return standingTicketPrice;
    }

    public void setStandingTicketPrice(BigDecimal standingTicketPrice) {
        this.standingTicketPrice = standingTicketPrice;
    }

    @Override
    public String toString() {
        return "Event{" +
                "eventId=" + eventId +
                ", eventCategory='" + eventCategory + '\'' +
                ", eventName='" + eventName + '\'' +
                ", eventDate=" + eventDate +
                ", eventTime=" + eventTime +
                ", eventLocation='" + eventLocation + '\'' +
                ", imgUrl='" + imgUrl + '\'' +
                ", seatTicketPrice=" + seatTicketPrice +
                ", standingTicketPrice=" + standingTicketPrice +
                '}';
    }
}
