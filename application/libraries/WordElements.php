<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
*
*/
class WordElements{

    function __construct()
    {
        # code...
    }
    public static function checkBox($name, $value){
        $value = $value ? 1 : 0;
        $t = '<w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr><w:fldChar w:fldCharType="begin"><w:ffData><w:name w:val="'.$name.'"/><w:enabled/><w:calcOnExit w:val="0"/><w:checkBox><w:sizeAuto/><w:default w:val="'.$value.'"/></w:checkBox></w:ffData></w:fldChar></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr><w:instrText xml:space="preserve"> FORMCHECKBOX </w:instrText></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr></w:r><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="14"/></w:rPr><w:fldChar w:fldCharType="end"/></w:r>';

        return $t;
    }
    public static function trfuentedec($actividad, $insumo, $tipo){
        $target = array('[[ACTI]]', '[[INS]]', '[[TIPO]]');
        $rep = array("$actividad", "$insumo", "$tipo");
        $tdos = '
            <w:tr w:rsidR="00A2724B" w:rsidRPr="00FB23C5" w:rsidTr="003D6700"><w:trPr><w:trHeight w:val="284"/><w:jc w:val="center"/></w:trPr><w:tc><w:tcPr><w:tcW w:w="0" w:type="auto"/><w:gridSpan w:val="5"/><w:vAlign w:val="center"/></w:tcPr><w:p w:rsidR="00A2724B" w:rsidRPr="00D74BEF" w:rsidRDefault="00D74BEF" w:rsidP="00D74BEF"><w:pPr><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:sz w:val="16"/><w:szCs w:val="16"/></w:rPr></w:pPr><w:proofErr w:type="spellStart"/><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:b/><w:color w:val="0000FF"/><w:sz w:val="16"/><w:szCs w:val="16"/></w:rPr><w:t>[[ACTI]]</w:t></w:r><w:proofErr w:type="spellEnd"/></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="0" w:type="auto"/><w:gridSpan w:val="5"/><w:vAlign w:val="center"/></w:tcPr><w:p w:rsidR="00A2724B" w:rsidRPr="00251831" w:rsidRDefault="00D74BEF" w:rsidP="00A80BFE"><w:pPr><w:jc w:val="both"/><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:b/><w:color w:val="0000FF"/><w:sz w:val="16"/><w:szCs w:val="16"/></w:rPr></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:b/><w:color w:val="0000FF"/><w:sz w:val="16"/><w:szCs w:val="16"/></w:rPr><w:t>[[INS]]</w:t></w:r><w:bookmarkStart w:id="0" w:name="_GoBack"/><w:bookmarkEnd w:id="0"/></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="0" w:type="auto"/><w:gridSpan w:val="2"/><w:vAlign w:val="center"/></w:tcPr><w:p w:rsidR="00A2724B" w:rsidRPr="00251831" w:rsidRDefault="00D74BEF" w:rsidP="00D63690"><w:pPr><w:jc w:val="center"/><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:b/><w:color w:val="0000FF"/><w:sz w:val="16"/><w:szCs w:val="16"/></w:rPr></w:pPr><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:b/><w:color w:val="0000FF"/><w:sz w:val="16"/><w:szCs w:val="16"/></w:rPr><w:t>[[TIPO]]</w:t></w:r></w:p></w:tc></w:tr>
        ';
        $tdos = str_replace($target, $rep, $tdos);
        $t = '<w:tr w:rsidR="003C2C3E" w:rsidRPr="00FB23C5" w:rsidTr="003D6700">
                <w:trPr>
                    <w:trHeight w:val="284"/>
                    <w:jc w:val="center"/>
                </w:trPr>
                <w:tc>
                    <w:tcPr>
                        <w:tcW w:w="0" w:type="auto"/>
                        <w:gridSpan w:val="5"/>
                        <w:vAlign w:val="center"/>
                    </w:tcPr>
                    <w:p w:rsidR="003C2C3E" w:rsidRDefault="003C2C3E" w:rsidP="00FC2911">
                        <w:pPr>
                            <w:rPr>
                                <w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/>
                                <w:sz w:val="16"/>
                                <w:szCs w:val="16"/>
                            </w:rPr>
                        </w:pPr>
                        <w:r>
                            <w:rPr>
                                <w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/>
                                <w:sz w:val="16"/>
                                <w:szCs w:val="16"/>
                            </w:rPr>
                            <w:t>BBBBBBBBBBBBBBBBBBBBBBBBBBBBB</w:t>
                        </w:r>
                    </w:p>
                </w:tc>
                <w:tc>
                    <w:tcPr>
                        <w:tcW w:w="0" w:type="auto"/>
                        <w:gridSpan w:val="5"/>
                        <w:vAlign w:val="center"/>
                    </w:tcPr>
                    <w:p w:rsidR="003C2C3E" w:rsidRDefault="003C2C3E" w:rsidP="00A80BFE">
                        <w:pPr>
                            <w:jc w:val="both"/>
                            <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/>
                                <w:b/>
                                <w:color w:val="0000FF"/>
                                <w:sz w:val="16"/>
                                <w:szCs w:val="16"/>
                            </w:rPr>
                        </w:pPr>
                    <w:proofErr w:type="spellStart"/>
                    <w:r>
                        <w:rPr>
                            <w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/>
                            <w:b/>
                            <w:color w:val="0000FF"/>
                            <w:sz w:val="16"/>
                            <w:szCs w:val="16"/>
                        </w:rPr>
                        <w:t>bbbbbbbbbbbbbbbbbbbb</w:t>
                    </w:r>
                    <w:proofErr w:type="spellEnd"/>
                    </w:p>
                </w:tc>
                <w:tc>
                    <w:tcPr>
                        <w:tcW w:w="0" w:type="auto"/>
                        <w:gridSpan w:val="2"/>
                        <w:vAlign w:val="center"/>
                    </w:tcPr>
                    <w:p w:rsidR="003C2C3E" w:rsidRDefault="003C2C3E" w:rsidP="00D63690">
                        <w:pPr>
                            <w:jc w:val="center"/>
                            <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/><w:b/><w:color w:val="0000FF"/><w:sz w:val="16"/><w:szCs w:val="16"/>
                            </w:rPr>
                        </w:pPr>
                        <w:r>
                            <w:rPr>
                                <w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:cs="Arial"/>
                                <w:b/>
                                <w:color w:val="0000FF"/>
                                <w:sz w:val="16"/>
                                <w:szCs w:val="16"/>
                            </w:rPr>
                            <w:t>2222222222222222</w:t>
                        </w:r>
                        <w:bookmarkStart w:id="0" w:name="_GoBack"/>
                        <w:bookmarkEnd w:id="0"/>
                    </w:p>
                </w:tc>
            </w:tr>';
    return $tdos;
    }
}

 ?>