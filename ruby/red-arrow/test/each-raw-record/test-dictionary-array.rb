# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

module EachRawRecordDictionaryArrayTests
  def build_record_batch(array)
    dictionary = array.dictionary_encode
    schema = Arrow::Schema.new(column: dictionary.value_data_type)
    Arrow::RecordBatch.new(schema, array.length, [dictionary])
  end

  def test_null
    records = [
      [nil],
      [nil],
      [nil],
      [nil],
    ]
    iterated_records = []
    target = build(Arrow::NullArray.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_boolean
    records = [
      [true],
      [nil],
      [false],
    ]
    iterated_records = []
    target = build(Arrow::BooleanArray.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_int8
    records = [
      [-(2 ** 7)],
      [nil],
      [(2 ** 7) - 1],
    ]
    iterated_records = []
    target = build(Arrow::Int8Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_uint8
    records = [
      [0],
      [nil],
      [(2 ** 8) - 1],
    ]
    iterated_records = []
    target = build(Arrow::UInt8Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_int16
    records = [
      [-(2 ** 15)],
      [nil],
      [(2 ** 15) - 1],
    ]
    iterated_records = []
    target = build(Arrow::Int16Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_uint16
    records = [
      [0],
      [nil],
      [(2 ** 16) - 1],
    ]
    iterated_records = []
    target = build(Arrow::UInt16Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_int32
    records = [
      [-(2 ** 31)],
      [nil],
      [(2 ** 31) - 1],
    ]
    iterated_records = []
    target = build(Arrow::Int32Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_uint32
    records = [
      [0],
      [nil],
      [(2 ** 32) - 1],
    ]
    iterated_records = []
    target = build(Arrow::UInt32Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_int64
    records = [
      [-(2 ** 63)],
      [nil],
      [(2 ** 63) - 1],
    ]
    iterated_records = []
    target = build(Arrow::Int64Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_uint64
    records = [
      [0],
      [nil],
      [(2 ** 64) - 1],
    ]
    iterated_records = []
    target = build(Arrow::UInt64Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_float
    records = [
      [-1.0],
      [nil],
      [1.0],
    ]
    iterated_records = []
    target = build(Arrow::FloatArray.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_double
    records = [
      [-1.0],
      [nil],
      [1.0],
    ]
    iterated_records = []
    target = build(Arrow::DoubleArray.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_binary
    records = [
      ["\x00".b],
      [nil],
      ["\xff".b],
    ]
    iterated_records = []
    target = build(Arrow::BinaryArray.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_string
    records = [
      ["Ruby"],
      [nil],
      ["\u3042"], # U+3042 HIRAGANA LETTER A
    ]
    iterated_records = []
    target = build(Arrow::StringArray.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_date32
    records = [
      [Date.new(1960, 1, 1)],
      [nil],
      [Date.new(2017, 8, 23)],
    ]
    iterated_records = []
    target = build(Arrow::Date32Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_date64
    records = [
      [DateTime.new(1960, 1, 1, 2, 9, 30)],
      [nil],
      [DateTime.new(2017, 8, 23, 14, 57, 2)],
    ]
    iterated_records = []
    target = build(Arrow::Date64Array.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_timestamp_second
    records = [
      [Time.parse("1960-01-01T02:09:30Z")],
      [nil],
      [Time.parse("2017-08-23T14:57:02Z")],
    ]
    iterated_records = []
    target = build(Arrow::TimestampArray.new(:second, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_timestamp_milli
    records = [
      [Time.parse("1960-01-01T02:09:30.123Z")],
      [nil],
      [Time.parse("2017-08-23T14:57:02.987Z")],
    ]
    iterated_records = []
    target = build(Arrow::TimestampArray.new(:milli, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_timestamp_micro
    records = [
      [Time.parse("1960-01-01T02:09:30.123456Z")],
      [nil],
      [Time.parse("2017-08-23T14:57:02.987654Z")],
    ]
    iterated_records = []
    target = build(Arrow::TimestampArray.new(:micro, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_timestamp_nano
    records = [
      [Time.parse("1960-01-01T02:09:30.123456789Z")],
      [nil],
      [Time.parse("2017-08-23T14:57:02.987654321Z")],
    ]
    iterated_records = []
    target = build(Arrow::TimestampArray.new(:nano, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_time32_second
    unit = Arrow::TimeUnit::SECOND
    records = [
      [Arrow::Time.new(unit, 60 * 10)], # 00:10:00
      [nil],
      [Arrow::Time.new(unit, 60 * 60 * 2 + 9)], # 02:00:09
    ]
    iterated_records = []
    target = build(Arrow::Time32Array.new(unit, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_time32_milli
    unit = Arrow::TimeUnit::MILLI
    records = [
      [Arrow::Time.new(unit, (60 * 10) * 1000 + 123)], # 00:10:00.123
      [nil],
      [Arrow::Time.new(unit, (60 * 60 * 2 + 9) * 1000 + 987)], # 02:00:09.987
    ]
    iterated_records = []
    target = build(Arrow::Time32Array.new(unit, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_time64_micro
    unit = Arrow::TimeUnit::MICRO
    records = [
      # 00:10:00.123456
      [Arrow::Time.new(unit, (60 * 10) * 1_000_000 + 123_456)],
      [nil],
      # 02:00:09.987654
      [Arrow::Time.new(unit, (60 * 60 * 2 + 9) * 1_000_000 + 987_654)],
    ]
    iterated_records = []
    target = build(Arrow::Time64Array.new(unit, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_time64_nano
    unit = Arrow::TimeUnit::NANO
    records = [
      # 00:10:00.123456789
      [Arrow::Time.new(unit, (60 * 10) * 1_000_000_000 + 123_456_789)],
      [nil],
      # 02:00:09.987654321
      [Arrow::Time.new(unit, (60 * 60 * 2 + 9) * 1_000_000_000 + 987_654_321)],
    ]
    iterated_records = []
    target = build(Arrow::Time64Array.new(unit, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_decimal128
    records = [
      [BigDecimal("92.92")],
      [nil],
      [BigDecimal("29.29")],
    ]
    iterated_records = []
    data_type = Arrow::Decimal128DataType.new(8, 2)
    target = build(Arrow::Decimal128Array.new(data_type, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_decimal256
    records = [
      [BigDecimal("92.92")],
      [nil],
      [BigDecimal("29.29")],
    ]
    iterated_records = []
    data_type = Arrow::Decimal256DataType.new(38, 2)
    target = build(Arrow::Decimal256Array.new(data_type, records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, target.raw_records)
  end

  def test_month_interval
    records = [
      [1],
      [nil],
      [12],
    ]
    iterated_records = []
    target = build(Arrow::MonthIntervalArray.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_day_time_interval
    records = [
      [{day: 1, millisecond: 100}],
      [nil],
      [{day: 2, millisecond: 300}],
    ]
    iterated_records = []
    target = build(Arrow::DayTimeIntervalArray.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end

  def test_month_day_nano_interval
    records = [
      [{month: 1, day: 1, nanosecond: 100}],
      [nil],
      [{month: 2, day: 3, nanosecond: 400}],
    ]
    iterated_records = []
    target = build(Arrow::MonthDayNanoIntervalArray.new(records.collect(&:first)))
    target.each_raw_record do |record|
      iterated_records << record
    end
    assert_equal(records, iterated_records)
  end
end

class EachRawRecordRecordBatchDictionaryArraysTest < Test::Unit::TestCase
  include EachRawRecordDictionaryArrayTests

  def build(array)
    build_record_batch(array)
  end
end

class EachRawRecordTableDictionaryArraysTest < Test::Unit::TestCase
  include EachRawRecordDictionaryArrayTests

  def build(array)
    build_record_batch(array).to_table
  end
end
