using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DotNetty.Buffers;

namespace dotNetty
{


    internal class ConsumerBuffer
    {
        private static Encoding encoding = Encoding.UTF8;

        private IByteBuffer buffer;
        /// <summary>
        /// 解码的时候使用
        /// </summary>
        private int endIndex;

        public IByteBuffer Buffer { get => buffer; set => buffer = value; }
        public int EndIndex { get => endIndex; set => endIndex = value; }

        public void EnsureWritable(int length)
        {
            buffer.EnsureWritable(length);
        }



        public void WriteVar32(int value)
        {
            uint v = (uint)value;
    
            while (true)
            {
                if ((v & ~0x7F) == 0)
                {
                    buffer.WriteByte((int)v);
                    return;
                }
                else
                {
                    buffer.WriteByte((int)(v & 0x7F) | 0x80);
                    v >>= 7;
                }
            }
        }


        public void WriteVar64(long value)
        {
            ulong v = (ulong)value;
            //Console.WriteLine("value = " + value + "  v = " + v);
            while (v >127)
            {
                buffer.WriteByte((int)((v & 0x7F) | 0x80));
                v >>= 7;
            }

            buffer.WriteByte((int)v);
        }

        public int EncodeZigZag32(int value)
        {
            return value << 1 ^ value >> 31;
        }

        public long EncodeZigZag64(long value)
        {
            return value << 1 ^ value >> 63;
        }

        public int DecodeZigZag32(int value)
        {
            // return (int)((n >> 1) ^ (0 - (n & 1)));
            uint v = (uint)value;

            return (int)(v >> 1 ^ -(v & 1));

        }

        public long DecodeZigZag64(long value)

        {
            ulong v = (ulong)value;
            return (long)((v >> 1) ^ (0 - (v & 1)));

        }


        int GetTagWriteType(int tag)
        {
            return tag & 7;
        }

        public int GetTagFieldNumber(int tag)
        {

            return tag >> 3;
        }

        public int MakeTag(int fieldIndex, int writeType)
        {
            return fieldIndex << 3 | writeType;
        }

        public void WriteBoolean(int tag, bool value)
        {

            WriteVar32(tag);
            WriteBoolean(value);

        }
     
        public void WriteBoolean(bool value)
        {
            buffer.WriteByte(value ? 1 : 0);
        }

        public void WriteVar32(int tag, int value)
        {
            //Constant.WIRETYPE_VARINT
            WriteVar32(tag);
            WriteVar32(value);
        }


        public void WriteVar64(int tag, long value)
        {
            WriteVar32(tag);
            WriteVar64(value);
        }


        public void WriteSInt(int tag, int value)
        {
            WriteVar32(tag);
            WriteVar32(EncodeZigZag32(value));
        }

        public void WriteSInt(int value)
        {
            WriteVar32(EncodeZigZag32(value));
        }


        public void WriteSLong(int tag, long value)
        {
            WriteVar32(tag);
            WriteVar64(EncodeZigZag64(value));
        }

        public void WriteSLong(long value)
        {
            WriteVar64(EncodeZigZag64(value));
        }

        public void WriteSFixed32(int tag, int value)
        {
            WriteVar32(tag);
            buffer.WriteInt(value);
        }

        public void WriteSFixed32(int value)
        {
            buffer.WriteInt(value);
        }


        public void WriteSFixed64(int tag, long value)
        {
            WriteVar32(tag);
            buffer.WriteLong(value);
        }

        public void WriteSFixed64(long value)
        {

            buffer.WriteLong(value);
        }

        public void WriteFloat(int tag, float value)
        {

            WriteVar32(tag);
            buffer.WriteFloat(value);
        }

        public void WriteFloat(float value)
        {
            buffer.WriteFloat(value);
        }

        public void WriteDouble(int tag, double value)
        {
            WriteVar32(tag);
            buffer.WriteDouble(value);
        }

        public void WriteDouble(double value)
        {
            buffer.WriteDouble(value);
        }

        public void WriteString(int tag, String value)
        {
            WriteVar32(tag);
            WriteString(value);
        }

        public void WriteString(String value)
        {
            byte[] bytes = encoding.GetBytes(value);
            WriteVar32(bytes.Length);
            buffer.WriteBytes(bytes);
        }

        public int ReaderIndex()
        {
            return buffer.ReaderIndex;
        }


        public static int TryReadVar32(IByteBuffer buffer)
        {
            if (!buffer.IsReadable())
            {
                return 0;
            }
            buffer.MarkReaderIndex();
            byte tmp = buffer.ReadByte();
            if (tmp < 128)
            {
                return tmp;
            }
            int result = tmp & 0x7f;
            if (!buffer.IsReadable())
            {
                buffer.ResetReaderIndex();
                return 0;
            }
            if ((tmp = buffer.ReadByte()) < 128)
            {
                result |= tmp << 7;
            }
            else
            {
                result |= (tmp & 0x7f) << 7;
                if (!buffer.IsReadable())
                {
                    buffer.ResetReaderIndex();
                    return 0;
                }
                if ((tmp = buffer.ReadByte()) < 128)
                {
                    result |= tmp << 14;
                }
                else
                {
                    result |= (tmp & 0x7f) << 14;
                    if (!buffer.IsReadable())
                    {
                        buffer.ResetReaderIndex();
                        return 0;
                    }
                    if ((tmp = buffer.ReadByte()) < 128)
                    {
                        result |= tmp << 21;
                    }
                    else
                    {
                        result |= (tmp & 0x7f) << 21;
                        if (!buffer.IsReadable())
                        {
                            buffer.ResetReaderIndex();
                            return 0;
                        }
                        result |= (tmp = buffer.ReadByte()) << 28;
                        if (tmp >=128)
                        {
                            // Discard upper 32 bits.
                            for (int i = 0; i < 5; i++)
                            {
                                if (buffer.ReadByte() < 128)
                                {
                                    return result;
                                }
                            }
                        }
                    }
                }
            }
            return result;
        }
        public int ReadVar32()
        {
            byte tmp = buffer.ReadByte();
            if (tmp <128)
            {
                return tmp;
            }
            int result = tmp & 0x7f;
            if ((tmp = buffer.ReadByte()) <128 )
            {
                result |= tmp << 7;
            }
            else
            {
                result |= (tmp & 0x7f) << 7;
                if ((tmp = buffer.ReadByte()) <128)
                {
                    result |= tmp << 14;
                }
                else
                {
                    result |= (tmp & 0x7f) << 14;
                    if ((tmp = buffer.ReadByte()) <128)
                    {
                        result |= tmp << 21;
                    }
                    else
                    {
                        result |= (tmp & 0x7f) << 21;
                        result |= (tmp = buffer.ReadByte()) << 28;
                        if (tmp >=128)
                        {
                            // Discard upper 32 bits.
                            for (int i = 0; i < 5; i++)
                            {
                                if (buffer.ReadByte() <128)
                                {
                                    return result;
                                }
                            }
                        }
                    }
                }
            }
            return result;
        }

        public long ReadVar64()
        {
            int shift = 0;
            long result = 0;
            while (shift < 64)
            {
                byte b = buffer.ReadByte();
                result |= (long)(b & 0x7F) << shift;
                if ((b & 0x80) == 0)
                {
                    return result;
                }
                shift += 7;
            }
            return result;
        }

        public String ReadString()
        {
            byte[] bytes = new byte[ReadVar32()];
            buffer.ReadBytes(bytes);

            return encoding.GetString(bytes);
        }



        public bool ReadBoolean()
        {
            return buffer.ReadBoolean();
        }

        public int ReadSInt()
        {

            return DecodeZigZag32(ReadVar32());
        }

        public long ReadSLong()
        {

            return DecodeZigZag64(ReadVar64());
        }

        public int ReadSFixed32()
        {

            return buffer.ReadInt();
        }

        public long ReadSFixed64()
        {

            return buffer.ReadLong();
        }

        public float ReadFloat()
        {

            return buffer.ReadFloat();
        }

        public double ReadDouble()
        {

            return buffer.ReadDouble();
        }



        public int ReadTag(int endIndex)
        {
            if (buffer.ReaderIndex == endIndex)
            {
                return 0;
            }
            return ReadVar32();
        }

        public void Skip(int tag)
        {
            switch (GetTagWriteType(tag))
            {
                case 0:
                    ReadVar64();
                    break;
                case 1:
                    buffer.SkipBytes(4);
                    break;
                case 2:
                    buffer.SkipBytes(8);
                    break;
                case 3:
                    buffer.SkipBytes(ReadVar32());
                    break;
            }
        }

        public int ComputeStringSize(int tagVar32Size, String value)
        {
            return tagVar32Size + ComputeStringSizeNoTag(value);
        }

        public int ComputeStringSizeNoTag(String value)
        {

            byte[] bytes = encoding.GetBytes(value);
            return ComputeVar32Size(bytes.Length) + bytes.Length;

        }



        public int ComputeBooleanSize(int tagVar32Size, bool value)
        {
            return tagVar32Size + ComputeBooleanSizeNoTag(value);
        }

        public int ComputeBooleanSizeNoTag(bool value)
        {
            return 1;
        }

        public int ComputeDoubleSize(int tagVar32Size, double value)
        {
            return tagVar32Size + ComputeDoubleSizeNoTag(value);
        }

        public int ComputeDoubleSizeNoTag(double value)
        {
            return 8;
        }

        public int ComputeFloatSize(int tagVar32Size, float value)
        {
            return tagVar32Size + ComputeFloatSizeNoTag(value);
        }

        public int ComputeFloatSizeNoTag(float value)
        {
            return 4;
        }

        public int ComputeSFixed32Size(int tagVar32Size, int value)
        {
            return tagVar32Size + ComputeSFixed32SizeNoTag(value);
        }

        public int ComputeSFixed32SizeNoTag(int value)
        {
            return 4;
        }

        public int ComputeSFixed64Size(int tagVar32Size, long value)
        {
            return tagVar32Size + ComputeSFixed64SizeNoTag(value);
        }

        public int ComputeSFixed64SizeNoTag(long value)
        {
            return 8;
        }

        public int ComputeSIntSize(int tagVar32Size, int value)
        {
            return tagVar32Size + ComputeSIntSizeNoTag(value);
        }

        public int ComputeSIntSizeNoTag(int value)
        {
            return ComputeVar32Size(EncodeZigZag32(value));
        }

        public int ComputeSLongSize(int tagVar32Size, long value)
        {
            return tagVar32Size + ComputeSLongSizeNoTag(value);
        }

        public int ComputeSLongSizeNoTag(long value)
        {
            return ComputeVar64Size(EncodeZigZag64(value));
        }


        public int ComputeVar32Size(int tagVar32Size, int value)
        {
            return tagVar32Size + ComputeVar32SizeNoTag(value);

        }

        public int ComputeVar32SizeNoTag(int value)
        {
            return value >= 0 ? ComputeVar32Size(value) : 5;
        }

        public int ComputeVar64Size(int tagVar32Size, long value)
        {
            return tagVar32Size + ComputeVar64SizeNoTag(value);

        }

        public int ComputeVar32Size(int value)
        {
            if ((value & -128) == 0)
            {
                return 1;
            }
            else if ((value & -16384) == 0)
            {
                return 2;
            }
            else if ((value & -2097152) == 0)
            {
                return 3;
            }
            else
            {
                return (value & -268435456) == 0 ? 4 : 5;
            }
        }

        public int ComputeVar64SizeNoTag(long value)
        {
            return value >= 0 ? ComputeVar64Size(value) : 10;
        }

        public int ComputeVar64Size(long value)
        {
            if ((value & -128L) == 0L)
            {
                return 1;
            }
            else if ((value & -16384L) == 0L)
            {
                return 2;
            }
            else if ((value & -2097152L) == 0L)
            {
                return 3;
            }
            else if ((value & -268435456L) == 0L)
            {
                return 4;
            }
            else if ((value & -34359738368L) == 0L)
            {
                return 5;
            }
            else if ((value & -4398046511104L) == 0L)
            {
                return 6;
            }
            else if ((value & -562949953421312L) == 0L)
            {
                return 7;
            }
            else if ((value & -72057594037927936L) == 0L)
            {
                return 8;
            }
            else
            {
                return (value & -9223372036854775808L) == 0L ? 9 : 10;
            }
        }
    }
}
