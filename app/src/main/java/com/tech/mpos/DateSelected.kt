package com.tech.mpos

interface DateSelected{
    fun receiveStartDate(year: Int, month: Int, dayOfMonth: Int)
    fun receiveEndDate(year: Int, month: Int, dayOfMonth: Int)
}