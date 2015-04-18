package com.mpp.model.entity;

import com.google.common.base.Objects;

/**
 * Created by xiang.xu on 2015/4/18.
 */
public class OrderFilter {
    private int labId;
    private int dayOfWeek;
    private int beginWeek;
    private int endWeek;
    private int length;
    private int status;

    public OrderFilter() {
    }

    public OrderFilter(final int labId, final int dayOfWeek, final int beginWeek, final int endWeek, final int length, final int status) {
        this.labId = labId;
        this.dayOfWeek = dayOfWeek;
        this.beginWeek = beginWeek;
        this.endWeek = endWeek;
        this.length = length;
        this.status = status;
    }

    public int getLabId() {
        return labId;
    }

    public void setLabId(final int labId) {
        this.labId = labId;
    }

    public int getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(final int dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public int getBeginWeek() {
        return beginWeek;
    }

    public void setBeginWeek(final int beginWeek) {
        this.beginWeek = beginWeek;
    }

    public int getEndWeek() {
        return endWeek;
    }

    public void setEndWeek(final int endWeek) {
        this.endWeek = endWeek;
    }

    public int getLength() {
        return length;
    }

    public void setLength(final int length) {
        this.length = length;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(final int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return Objects.toStringHelper(this)
                .add("labId", labId)
                .add("dayOfWeek", dayOfWeek)
                .add("beginWeek", beginWeek)
                .add("endWeek", endWeek)
                .add("length", length)
                .add("status", status)
                .toString();
    }
}
