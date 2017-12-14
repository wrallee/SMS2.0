<title>이준빈은 호박머리(CSS)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style>
div label input {
   margin-right:100px;
}
#ck-button {
    margin:4px;
    background-color:#EFEFEF;
    border-radius:4px;
    border:1px solid #D0D0D0;
    overflow:auto;
    float:left;
}
#ck-button label {
    float:left;
    width:4.0em;
}
#ck-button label span {
    text-align:center;
    padding:3px 0px;
    display:block;
}
#ck-button label input {
    position:absolute;
    top:-20px;
}
#ck-button input:checked + span {
    background-color:#911;
    color:#fff;
}
</style>
 
<!--기본(Default)-->
<div>
    <input type="radio" name="ss" id="ss" value="1" checked=""><span>radio_1</span>
    <input type="radio" name="ss" id="ss" value="1"><span>radio_1</span>
 
    <input type="checkbox" name="sss" id="sss" value="3" checked=""><span>check_1</span>
    <input type="checkbox" name="sss" id="sss" value="3"><span>check_1</span>
</div>
<!--기본(Default)-->
 
<!--변경(Changed)-->
<div>
    <div id="ck-button">
       <label>
          <input type="radio" name="ss2" id="ss2" value="1" checked=""><span>radio_1</span>
       </label>
    </div>
 
    <div id="ck-button">
       <label>
          <input type="radio" name="ss2" id="ss2" value="2"><span>radio_2</span>
       </label>
    </div>
 
    <div id="ck-button">
       <label>
     <input type="checkbox" name="sss2" id="sss2" value="3" checked=""><span>check_1</span>
       </label>
    </div>
 
    <div id="ck-button">
       <label>
          <input type="checkbox" name="sss2" id="sss2" value="3"><span>check_2</span>
       </label>
    </div>
</div>
<!--변경(Changed)-->